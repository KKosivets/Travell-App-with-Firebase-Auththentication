import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    
    @State var signUpProcessing = false
    @State var signUpErrorMessage = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Image("logo1")
                .padding()
        
            SignUpCredentialFields(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
            Button(action: {
                signUpUser(userEmail: email, userPassword: password)
            }) {
                Text("Зарегистрироваться")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
                .disabled(!signUpProcessing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true)
            if signUpProcessing {
                ProgressView()
            }
            if !signUpErrorMessage.isEmpty {
                Text("Не удалось создать учетную запись: \(signUpErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Уже зарегистрированы?")
                Button(action: {
                    viewRouter.currentPage = .signInPage
                }) {
                    Text("Войти")
                }
            }
                .opacity(0.9)
        }
            .padding()
    }
    
    func signUpUser(userEmail: String, userPassword: String) {
        
        signUpProcessing = true
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                signUpErrorMessage = error!.localizedDescription
                signUpProcessing = false
                return
            }
            
            switch authResult {
            case .none:
                print("Не удалось создать учетную запись.")
                signUpProcessing = false
            case .some(_):
                print("Пользователь создан")
                signUpProcessing = false
                viewRouter.currentPage = .homePage
            }
        }
        
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .previewDevice("iPhone 11")
    }
}

struct LogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 150)
            .padding(.top, 70)
    }
}

struct SignUpCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
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
            SecureField("Подверждение пароля", text: $passwordConfirmation)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .border(Color.red, width: passwordConfirmation != password ? 1 : 0)
                .padding(.bottom, 30)
        }
    }
}

