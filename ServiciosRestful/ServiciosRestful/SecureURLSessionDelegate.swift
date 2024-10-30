//
//  SecureURLSessionDelegate.swift
//  ServiciosRestful
//
//  Created by epismac on 29/10/24.
//

import Foundation

class SecureURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let serverTrust = challenge.protectionSpace.serverTrust {
            
            // Se carga el certificado local almacenado en el proyecto
            if let certificatePath = Bundle.main.path(forResource: "localhost", ofType: "cer"),
               let localCertificateData = try? Data(contentsOf: URL(fileURLWithPath: certificatePath)) {
                
                // Se obtiene el primer certificado en la cadena del servidor
                if let serverCertificate = (SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate])?.first {
                    let serverCertificateData = SecCertificateCopyData(serverCertificate) as Data
                    
                    // se compara el certificado del servidor con el certificado local
                    if serverCertificateData == localCertificateData {
                        let credential = URLCredential(trust: serverTrust)
                        completionHandler(.useCredential, credential)
                        return
                    }
                }
            }
        }
        // Si la autenticación no es válida, se cancelar
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
