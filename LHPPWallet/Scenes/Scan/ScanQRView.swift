//
//  ScanQRView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 21/4/26.
//

import SwiftUI
import AVFoundation

struct ScanQRView: View {
   
        @State private var showScanner = false
            @State private var result = ""
            
            var body: some View {
                VStack {
                    Text("Result: \(result)")
                    
                    Button("Scan QR") {
                        showScanner = true
                    }
                }
                .sheet(isPresented: $showScanner) {
                    QRScannerView { value in
                        result = value
                        showScanner = false
                    }
                }
            }
    
}

struct QRScannerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ScannerVC

    let onScan: (String) -> Void

    func makeUIViewController(context: Context) -> ScannerVC {
        let vc = ScannerVC()
        vc.onScan = onScan
        return vc
    }

    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
}

class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let session = AVCaptureSession()
    var onScan: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        let output = AVCaptureMetadataOutput()
        
        session.addInput(input)
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.frame = view.layer.bounds
        view.layer.addSublayer(preview)
        
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let value = object.stringValue {
            
            print("QR Code:", value) // payload
            onScan?(value)
            session.stopRunning()
            // Dismiss if presented modally
            if presentingViewController != nil {
                dismiss(animated: true)
            }
        }
    }
}

#Preview {
    ScanQRView()
}

