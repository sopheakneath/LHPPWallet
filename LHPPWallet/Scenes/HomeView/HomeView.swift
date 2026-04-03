//
//  HomeView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 31/3/26.
//

import SwiftUI

@available(iOS 15.0, *)
struct HomeView: View {
   @State private var isShowBalance: Bool = false
    var body: some View {
        NavigationView{
            ScrollView {
                HomeHeader(isShowbalance: $isShowBalance)
                
                HStack{
                    Text("Service")
                        .font(.maliRegular)
                    Spacer()
                    Text("See more")
                        .font(.maliRegular)
                        .onTapGesture {
                            print("GO TO ")
                        }
                }
                .padding(.horizontal, 17)
              // --------------
                
               HomeFeature()
                    .task {
                        print("")
                    }
            HStack{
                    Text("Recent Transaction")
                    .font(.maliRegular)
                    Spacer()
                    Text("See more")
                    .font(.maliRegular)
                    .foregroundColor(Color.blue)
                        .onTapGesture {
                            print("GO TO ")
                        }
                }
                .padding(.horizontal, 17)

                TransferList(items: [1,2,3,4])
                    .padding(5)
                
                HStack{
                        Text("Scedule")
                        .font(.maliRegular)
                        Spacer()
                        Text("See more")
                        .font(.maliRegular)
                        .foregroundColor(Color.blue)
                            .onTapGesture {
                                print("GO TO ")
                            }
                    }
                    .padding(.horizontal, 17)
                
                TransferList(items: [1,2])
                    .padding(5)
                HStack {
                    Text("New")
                        .font(.maliMedium)
                    Spacer()
                    Text("")
                }.padding(.horizontal, 20)
                BannerView()
                    .padding(.bottom, 50)
            }
           
          //  .background(Color.black)
        }
       
    }
}




struct RoundedCorner: Shape {
    var radius: CGFloat = 12
    var corners: UIRectCorner = []

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


struct CustomCorner: Shape {
    var topLeft: CGFloat = 0
    var topRight: CGFloat = 0
    var bottomLeft: CGFloat = 0
    var bottomRight: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Ensure radius does not exceed bounds
        let tr = min(min(topRight, h/2), w/2)
        let tl = min(min(topLeft, h/2), w/2)
        let bl = min(min(bottomLeft, h/2), w/2)
        let br = min(min(bottomRight, h/2), w/2)

        path.move(to: CGPoint(x: w/2, y: 0))

        // Top Right
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr),
                    radius: tr,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(0),
                    clockwise: false)

        // Bottom Right
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br),
                    radius: br,
                    startAngle: .degrees(0),
                    endAngle: .degrees(90),
                    clockwise: false)

        // Bottom Left
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl),
                    radius: bl,
                    startAngle: .degrees(90),
                    endAngle: .degrees(180),
                    clockwise: false)

        // Top Left
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl),
                    radius: tl,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)

        path.closeSubpath()

        return path
    }
}


#Preview {
    if #available(iOS 15.0, *) {
        HomeView()
    } else {
        // Fallback on earlier versions
    }
}

