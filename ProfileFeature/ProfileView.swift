//
//  ProfileView.swift
//  ProfileFeature
//
//  Created by Mohamed Elmalhey on 21/09/2025.
//

import SwiftUI
import SDWebImageSwiftUI

public protocol ProfileRouter {
    func navigateOnLogout() -> AnyView
}

public struct DefaultProfileRouter: ProfileRouter {
    public init() {}
    public func navigateOnLogout() -> AnyView {
        AnyView(Text("After logout ...."))
    }
}

public struct ProfileView: View {
    var user: ProfileUser
    var onLogout: (() -> Void)?
    @State private var showLogoutAlert = false
    public init(user: ProfileUser, onLogout: (() -> Void)?) {
        self.user = user
        self.onLogout = onLogout
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                WebImage(url: user.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 8)
                Spacer()
            }
            // User Info Fields
            VStack(spacing: 16) {
                ProfileField(label: "Username", value: user.username)
                ProfileField(label: "Email", value: user.email)
                ProfileField(label: "First Name", value: user.firstName)
                ProfileField(label: "Last Name", value: user.lastName)
            }
            .padding(.horizontal, 24)
            Spacer()
            Button(action: {
                showLogoutAlert = true
            }) {
                Text("Logout")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
            }
            .background(Color(#colorLiteral(red: 0.1367000341, green: 0.6366661191, blue: 0.2845686078, alpha: 1)))
            .background(in: RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .padding(.top, 40)
        .background(Color(.systemGroupedBackground))
        .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
            Button("Yes", role: .destructive) {
                onLogout?()
            }
            Button("No", role: .cancel) {}
        }
    }
}

struct ProfileField: View {
    let label: String
    let value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
        }
    }
}

#Preview {
    ProfileView(user: ProfileUser(username: "johndoe",
                                  email: "john@example.com",
                                  firstName: "John",
                                  lastName: "Doe",
                                  image: URL(string: "https://i.pravatar.cc/300")!), onLogout: nil)
}
