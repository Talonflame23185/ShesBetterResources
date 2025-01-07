//
//  ForgotPasswordView.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 12/30/24.
//
import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var isRequestSent = false
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            // Background image
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#5ef7e8"), Color(hex: "#f567db")]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // Shes better logo at the top
                Image("ShesBetterLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.top, -100)

                // Title
                Text("Forgot Password")
                    .font(.custom("Lora-Regular", size: 35))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                // Instruction Text
                Text("Enter your email to receive reset instructions.")
                    .font(.custom("Lora-Regular", size: 24))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                // Email TextField styled like Login and Signup
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email")
                        .font(.custom("Lora-Regular", size: 18))
                        .foregroundColor(.white)

                    TextField("name@example.com", text: $email)
                        .padding()
                        .background(Color(hex: "#a2fbfc"))
                        .cornerRadius(10)
                        .foregroundColor(Color(hex: "#a2fbfc"))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                // Submit Button styled to match other views
                Button(action: {
                    sendPasswordReset()
                }) {
                    Text("Submit")
                        .font(.custom("Lora-Regular", size: 24))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#fc8bea"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Confirmation or Error Message
                if isRequestSent {
                    Text("Password reset instructions have been sent to your email.")
                        .font(.custom("Lora-Regular", size: 14))
                        .foregroundColor(.green)
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.custom("Lora-Regular", size: 14))
                        .foregroundColor(.red)
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }

                Spacer()
            }
            .padding()
        }
    }

    private func sendPasswordReset() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address."
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                // Display error message
                self.errorMessage = error.localizedDescription
                self.isRequestSent = false
            } else {
                // Display confirmation message
                self.isRequestSent = true
                self.errorMessage = nil
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
