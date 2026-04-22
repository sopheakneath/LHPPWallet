//
//  TransactionListView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 24/3/26.
//

import SwiftUI
import UIKit

@available(iOS 15.0, *)
struct TransactionListView: View {
    
    @StateObject var viewModel = TransactionViewModel()
    @State var isGoToDetail : Bool = false
    var body: some View {
        ZStack {
            VStack {
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle())
                  
                if  viewModel.isloading  {
                            ProgressView()
                        .padding(.top, 50)
                    
                }
                
                CollectionViewWrapper(isGoToDetail: $isGoToDetail, transactions: viewModel.item)
                    
//                    .refreshable {
//                        print("I'm refresh \(refresh)")
//                        await refresh()
//                        
//                    }
                
//                if viewModel.item.isEmpty {
//                    ProgressView()
//                }else {
//                    CollectionViewWrapper(transactions: viewModel.item)
//                        .refreshable {
//                            guard !isLoading else { return }
//                            await refresh()
//                        }
//                }
              
                
            }
//            if isLoading {
//                ZStack {
//                    Text("LOSINF")
//                        .background(Color.red)
//                    Color.black.opacity(0.05).ignoresSafeArea()
//                    ProgressView("Loading…")
//                        .progressViewStyle(CircularProgressViewStyle())
//                        .padding()
//                        .background(Color(.systemBackground))
//                        .cornerRadius(12)
//                }
//                .background(Color.red)
//            }
        }
        .task {
            await refresh()
            
        }
        .refreshable {
            print(" refresh 123")
        }
        .padding(.vertical, 50)
        .ignoresSafeArea()
        .background(Color(UIColor.systemGray6))
        .padding(.bottom, 50)
        
    }
    
   

    @MainActor
    private func refresh() async {
        viewModel.isloading = true
        await viewModel.getTransactionAsync()
    }
       
}
// ---------------

final class RefreshableCollectionViewController: UICollectionViewController {
    var onRefresh: (() async -> Void)?
    private let refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    @objc private func handleRefresh() {
        guard let onRefresh else {
            refreshControl.endRefreshing()
            return
        }
        Task { @MainActor in
            await onRefresh()
            self.refreshControl.endRefreshing()
        }
    }
}

struct CollectionViewWrapper: UIViewControllerRepresentable {
    
    @Binding var isGoToDetail: Bool

    
    let transactions: [TransactionModel]

    func makeUIViewController(context: Context) -> RefreshableCollectionViewController {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 34)
        
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0

        let vc = RefreshableCollectionViewController(collectionViewLayout: layout)
        vc.collectionView.register(HostingCollectionViewCell.self,
                                   forCellWithReuseIdentifier: "cell")
        vc.collectionView.register(
            HostingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        vc.collectionView.dataSource = context.coordinator
        vc.collectionView.delegate = context.coordinator
        vc.collectionView.backgroundColor = UIColor.systemGray6
       // vc.onRefresh = onRefresh
        return vc
    }

    func updateUIViewController(_ uiViewController: RefreshableCollectionViewController, context: Context) {
        context.coordinator.transactions = transactions
        uiViewController.collectionView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(transactions: transactions, isGoToDetail: $isGoToDetail)
    }
}
// ---------------
class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private struct TransactionSection {
        let headerTitle: String
        let headerDate: Date?
        var items: [TransactionModel]
    }

    private var sections: [TransactionSection] = []

    var transactions: [TransactionModel] {
        didSet { rebuildSections() }
    }
    
    private var isGoToDetail: Binding<Bool>

    init(transactions: [TransactionModel], isGoToDetail: Binding<Bool>) {
        self.transactions = transactions
        self.isGoToDetail = isGoToDetail
        super.init()
        rebuildSections()
    }

    private func txnDateKey(from txnDate: String) -> String {
        // Format example in your model mock: "24 Mar 2026, 11:37 AM"
        if let firstPart = txnDate.split(separator: ",", maxSplits: 1).first {
            return firstPart.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return txnDate.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func parseTxnDate(_ txnDate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        let formats = [
            "dd MMM yyyy, h:mm a",
            "dd MMM yyyy, hh:mm a",
            "d MMM yyyy, h:mm a",
            "d MMM yyyy, hh:mm a",
            "dd MMM yyyy"
        ]

        for format in formats {
            formatter.dateFormat = format
            if let d = formatter.date(from: txnDate) {
                return d
            }
        }

        let key = txnDateKey(from: txnDate)
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.date(from: key)
    }

    private func rebuildSections() {
        if transactions.isEmpty {
            sections = []
            return
        }

        var grouped: [String: [TransactionModel]] = [:]
        for txn in transactions {
            let key = txnDateKey(from: txn.txnDate)
            grouped[key, default: []].append(txn)
        }
        var rebuilt: [TransactionSection] = []
        for (key, txns) in grouped {
            let sortedItems = txns.sorted {
                (parseTxnDate($0.txnDate) ?? .distantPast) > (parseTxnDate($1.txnDate) ?? .distantPast)
            }
            let headerDate = sortedItems.first.flatMap { parseTxnDate($0.txnDate) }
            rebuilt.append(TransactionSection(headerTitle: key, headerDate: headerDate, items: sortedItems))
        }
        rebuilt.sort { (lhs, rhs) -> Bool in
            (lhs.headerDate ?? .distantPast) > (rhs.headerDate ?? .distantPast)
        }

        sections = rebuilt
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! HostingCollectionViewCell
        let transaction = sections[indexPath.section].items[indexPath.row]
        cell.host(
            SwiftUICellView(transaction: transaction, isGoToDetail: isGoToDetail)
        )
        return cell
    }
    // layout cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width > 0
            ? collectionView.bounds.width
            : UIScreen.main.bounds.width
        let transaction = sections[indexPath.section].items[indexPath.row]
       //  Custom  dynamic   height matches multiline text.
        let host = UIHostingController(rootView: SwiftUICellView(transaction: transaction, isGoToDetail: isGoToDetail))
        let target = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        var height = host.view.systemLayoutSizeFitting(
            target,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height
           
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped item at \(indexPath.row)")
    }
    
//    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
//        
//        
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
//                                                      for: indexPath) as! HostingCollectionViewCell
//        let transaction = sections[indexPath.section].items[indexPath.row]
//        cell.host(
//            SwiftUICellView(transaction: transaction, isGoToDetail: isGoToDetail)
//        )
//        return cell
//    }
    
// MARK  : Custom  dynamic   height matches multiline text. // 
    
//    private static func measureCellHeight(for transaction: TransactionModel, fittingWidth width: CGFloat) -> CGFloat {
//        let host = UIHostingController(rootView: SwiftUICellView(transaction: transaction))
//        host.view.translatesAutoresizingMaskIntoConstraints = false
//        host.view.backgroundColor = .clear
//
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
//        container.addSubview(host.view)
//
//        NSLayoutConstraint.activate([
//            host.view.widthAnchor.constraint(equalToConstant: width),
//            host.view.topAnchor.constraint(equalTo: container.topAnchor),
//            host.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
//            host.view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
//        ])
//
//        container.layoutIfNeeded()
//        host.view.setNeedsLayout()
//        host.view.layoutIfNeeded()
//
//        let target = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
//        var height = host.view.systemLayoutSizeFitting(
//            target,
//            withHorizontalFittingPriority: .required,
//            verticalFittingPriority: .fittingSizeLevel
//        ).height
//
//        if height < 2, #available(iOS 16.0, *) {
//            height = host.view.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
//        }
//        
//        
//        height = host.view.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
//
//        return ceil(max(height, 1))
//    }

    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "header",
            for: indexPath
        ) as! HostingCollectionReusableView

        let title = sections[indexPath.section].headerTitle
        header.host(
            Text(title)
                .font(.maliRegular)
                .foregroundColor(Color(UIColor.darkGray))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.vertical, 10)
                .background(Color(UIColor.systemGray6))
        )
       
        return header
    }
}

//-----------------

class HostingCollectionViewCell: UICollectionViewCell {

    private var hostingController: UIHostingController<AnyView>?

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
    
    func host<Content: View>(_ view: Content) {
        if let hostingController = hostingController {
            hostingController.rootView = AnyView(view)
        } else {
            let hc = UIHostingController(rootView: AnyView(view))
            hc.view.translatesAutoresizingMaskIntoConstraints = false

            contentView.addSubview(hc.view)

            NSLayoutConstraint.activate([
                hc.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                hc.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                hc.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hc.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])

            hostingController = hc
        }
    }
}

class HostingCollectionReusableView: UICollectionReusableView {
    private var hostingController: UIHostingController<AnyView>?
   // private var hostingController: UIHostingConfiguration<AnyView>?
    func host<Content: View>(_ view: Content) {
        if let hostingController = hostingController {
            hostingController.rootView = AnyView(view)
        } else {
            let hc = UIHostingController(rootView: AnyView(view))
            hc.view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(hc.view)

            NSLayoutConstraint.activate([
                hc.view.topAnchor.constraint(equalTo: topAnchor),
                hc.view.bottomAnchor.constraint(equalTo: bottomAnchor),
                hc.view.leadingAnchor.constraint(equalTo: leadingAnchor),
                hc.view.trailingAnchor.constraint(equalTo: trailingAnchor)
              
            ])
           
            hostingController = hc
        }
    }
}


struct SwiftUICellView: View {
    let transaction: TransactionModel
    @Binding var isGoToDetail: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 8) {
                Image((transaction.icon.isEmpty == false) ? transaction.icon : "logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .cornerRadius(30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.accountName)
                        .font(.MaliSemiBold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(transaction.txnDate)
                        .font(.maliRegular)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(transaction.isDebit ? "-" : "+")\(String(format:"%.2f", transaction.amount)) \(transaction.currency)")
                        .font(.MaliSemiBold)
                    // .foregroundColor(Color.red)
                        .foregroundColor(transaction.isDebit ? .red : .green)
                    Text(" ")
                }
            }
            .padding(14)
         
//            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0.5))
             .background(Color(UIColor.white))
            .onTapGesture {
                isGoToDetail = true
                
                print("hello : \(transaction.txnNoInCbs) ")
                let uuid = NSUUID().uuidString
                print(uuid)
            }
            .cornerRadius(8)
             .padding(.horizontal, 20)
             .background(Color(UIColor.systemGray6))
            
            if #available(iOS 15.0, *) {
                NavigationLink(destination: TransactionDetailView(txnNo: transaction.txnNoInCbs), isActive: $isGoToDetail) {
                   //
                    EmptyView()
                }
            } else {
                // Fallback on earlier versions
                
            }
        }
    }
}



#Preview {
    if #available(iOS 15.0, *) {
        TransactionListView()
    } else {
        // Fallback on earlier versions
    }
}

extension TransactionViewModel {
    @MainActor
    func getTransactionAsync() async {
       
        await withCheckedContinuation { continuation in
            getTransaction()
            continuation.resume()
        }
    }
}


