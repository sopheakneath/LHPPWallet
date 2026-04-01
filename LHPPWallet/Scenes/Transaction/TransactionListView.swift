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
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Transaction")
                    .font(.headline)
                    .padding(.top, 50)
                CollectionViewWrapper(transactions: viewModel.item)
                    .refreshable {
                        guard !isLoading else { return }
                        await refresh()
                    }
                
            }
            if isLoading {
                ZStack {
                    Color.black.opacity(0.05).ignoresSafeArea()
                    ProgressView("Loading…")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                }
            }
        }
        .task {
            isLoading = true
            await refresh()
            print("loading")
        }
        .padding(.vertical, 50)
        
        .ignoresSafeArea()
        .background(Color(UIColor.systemGray6))
        .padding(.bottom, 50)
        
    }
    
    private func setLoading(_ loading: Bool) {
        isLoading = loading
    }

    @MainActor
    private func refresh() async {
        setLoading(true)
        defer { setLoading(false) }
        await viewModel.getTransactionAsync()
    }
       
}
// ---------------

struct CollectionViewWrapper: UIViewControllerRepresentable {
    
    let transactions: [TransactionModel]

    func makeUIViewController(context: Context) -> UICollectionViewController {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 34)
        
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0

        let vc = UICollectionViewController(collectionViewLayout: layout)
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
        return vc
    }

    func updateUIViewController(_ uiViewController: UICollectionViewController, context: Context) {
        context.coordinator.transactions = transactions
        uiViewController.collectionView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(transactions: transactions)
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

    init(transactions: [TransactionModel]) {
        self.transactions = transactions
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
            SwiftUICellView(transaction: transaction)
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
        let host = UIHostingController(rootView: SwiftUICellView(transaction: transaction))
        let target = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        var height = host.view.systemLayoutSizeFitting(
            target,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height
        return CGSize(width: width, height: height)
    }
    
    
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
                print("hello")
            }
            .cornerRadius(8)
             .padding(.horizontal, 20)
             .background(Color(UIColor.systemGray6))
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


