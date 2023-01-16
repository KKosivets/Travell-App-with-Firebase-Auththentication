import SwiftUI
import Firebase

struct SignInView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Image("logo1")
                .padding()
            SignInCredentialFields(email: $email, password: $password)
            Button(action: {
                signInUser(userEmail: email, userPassword: password)
            }) {
                Text("Войти")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
                .disabled(!signInProcessing && !email.isEmpty && !password.isEmpty ? false : true)
            if signInProcessing {
                ProgressView()
            }
            if !signInErrorMessage.isEmpty {
                Text("Не удалось войти в аккаунт: \(signInErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Нет аккаунта?")
                Button(action: {
                    viewRouter.currentPage = .signUpPage
                }) {
                    Text("Зарегистрируйтесь")
                }
            }
                .opacity(0.9)
        }
            .padding()
    }
    
    func signInUser(userEmail: String, userPassword: String) {
        
        signInProcessing = true
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Не удалось войти в систему.")
                signInProcessing = false
            case .some(_):
                print("Пользователь выполнил вход")
                signInProcessing = false
                withAnimation {
                    viewRouter.currentPage = .homePage
                }
            }
            
        }

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .previewDevice("iPhone 11")
    }
}

struct SignInCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            SecureField("Пароль", text: $password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding(.bottom, 30)
        }
    }
}
