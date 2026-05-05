//
//  TransactionDetailView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 20/4/26.
//

import SwiftUI



@available(iOS 15.0, *)
struct TransactionDetailView: View {
    
    @StateObject var vm = TransactionDetailViewModel()
    let txnNo: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Transfer Detail")
                .padding(.vertical, 20)
                .padding(.horizontal,10)
            HStack(){
                VStack (alignment: .leading){
                    Text("Service")
                        .font(.maliRegular)
                    Text(vm.transactionDetail?.description ?? "_")
                        .font(.MaliSemiBold)
                    
                    Text("From Account")
                        .font(.maliRegular)
                    Text(vm.transactionDetail?.senderAcc ?? "_")
                        .font(.MaliSemiBold)
                    
                    Text("To")
                        .font(.maliRegular)
                    Text(vm.transactionDetail?.receiverAcc ?? "_")
                        .font(.MaliSemiBold)
                    
                    Text("Transaction Number")
                        .font(.maliRegular)
                    Text(vm.transactionDetail?.trxNum ?? "_")
                        .font(.MaliSemiBold)
                    
                    Text("Auth reference number")
                        .font(.maliRegular)
                    Text(vm.transactionDetail?.AuthNUM ?? "_")
                        .font(.MaliSemiBold)
                    
                    Text("Date and Time")
                        .font(.maliRegular)
                    Text(vm.transactionDetail?.date ?? "_")
                        .font(.MaliSemiBold)
                    
                }
                Spacer()
                VStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 30,height: 30)
                   
                    Image("downarrow")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .padding(.vertical, 70)
                    
                    Image("wing")
                        .resizable()
                        .frame(width: 30,height: 30)
                   
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .shadow(radius: 2)
            
            
            Text("Amount Detail")
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
            HStack(){
                VStack (alignment: .leading){
                    Text("Sending Amount")
                        .font(.maliRegular)
                    
                    Text("99.23")
                        .font(.maliMedium)
                        .padding(.bottom,2)
                    Text("Sending Currency")
                        .font(.maliRegular)
                    Text(vm.transactionDetail?.currency ?? "-")
                        .padding(.bottom,2)
                       
                    
                    Text("Fee Amount")
                        .font(.maliRegular)
                    Text(vm.transactionDetail?.feeAmount ?? "_")
                        .font(.maliMedium)

                }
               
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
                .padding(.leading, 10)
               
                
            
                Spacer()
                VStack(alignment: .trailing ) {
                    VStack(alignment: .trailing){
                        Text("Excange Rate")
                            .font(.maliRegular)
                            
                        Text("use 1 = 4100 kh")
                            .font(.MaliSemiBold)
                            
                        Text("Transfer Amount")
                            .font(.maliRegular)
                        Text("Transfer Amount")
                      //  let amout = vm.transactionDetail?.amount.scanUpToString(<#T##String#>)
                       // Text(vm.transactionDetail?.amount ?? "-")
                            .font(.maliMedium)
                    }
                    .frame(maxWidth : .infinity)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    
                    VStack(alignment: .trailing){
                        Text("Total Amount")
                            .font(.maliRegular)
                        Text("")
                            .font(.MaliSemiBold)
                      
                    }
                    .frame(maxWidth : .infinity)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                   
                }
                .padding(.trailing,10)
                .padding(.vertical,10)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
           // .padding(.vertical,10)
            .background(Color.lightGray)
            .cornerRadius(10)
            .frame(maxWidth: .infinity, alignment: .leading)
           // .padding(10)
           // .background(Color.red)
            .cornerRadius(10)
           // .padding(.horizontal, 10)
            
            
            Spacer()
            Text("Action")
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
            HStack(spacing: 0) {
                Button {
                    
                }label: {
                    VStack {
                        Image("icon_download")
                           
                            .resizable()
                            .frame(width: 12, height: 15)
                            .padding(.horizontal,20)
                            .padding(.vertical,11)
                            .background()
                            .cornerRadius(10)
                        Text("Download")
                            .font(.maliRegular)
                            .foregroundColor(Color.gray)
                    }
                    
                }
                    .frame(maxWidth: .infinity)
                Button {
                    
                }label: {
                    VStack {
                        Image("icon_share")
                           
                            .resizable()
                            .frame(width: 12, height: 15)
                            .padding(.horizontal,20)
                            .padding(.vertical,11)
                            .background()
                            .cornerRadius(10)
                        Text("Share")
                            .font(.maliRegular)
                            .foregroundColor(Color.gray)
                    }
                    
                }
                    .frame(maxWidth: .infinity)
                    
                Button {
                    
                }label: {
                    VStack {
                        Image("icon_repeat")
                           
                            .resizable()
                            .frame(width: 12, height: 15)
                            .padding(.horizontal,20)
                            .padding(.vertical,11)
                            .background()
                            .cornerRadius(10)
                        Text("Report")
                            .font(.maliRegular)
                            .foregroundColor(Color.gray)
                    }
                    
                }
                    .frame(maxWidth: .infinity)
                Button {
                    
                } label: {
                    VStack {
                        Image("icon_history")
                            .resizable()
                            .frame(width: 12, height: 15)
                            .padding(.horizontal,20)
                            .padding(.vertical,11)
                            .background()
                            .cornerRadius(10)
                        Text("History")
                            .font(.maliRegular)
                            .foregroundColor(Color.gray)
                    }
                }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom , 10)
            }
      
            
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
       // .padding(10)
       
        .background(Color.lightGray)
        .cornerRadius(10)
        .padding(.horizontal, 12)
        
        .task {
            vm.fetchTransactionDetail(txnNo: txnNo)
            
        }
       
        // Optional padding
        .customBackToolbar(title: "Transaction Detail")
    }
}
#Preview {
    if #available(iOS 15.0, *) {
        TransactionDetailView(txnNo: "TXN003")
    } else {
        // Fallback on earlier versions
    }
}


// get id of transaction from transaction list to get transaction detail
