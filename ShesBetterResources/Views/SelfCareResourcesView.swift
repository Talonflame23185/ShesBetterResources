//
//  SelfCareResourcesView.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 12/30/24.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct SelfCareResourcesView: View {
    @State private var searchText = ""
    @State private var selfCareResources: [ResourceItem] = [] // Dynamic resources fetched from Firestore
    private let db = Firestore.firestore()

    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Self-Care Resources")
                .font(.custom("Lora-Regular", size: 35))
                .foregroundColor(Color(hex: "ffffff"))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)

            // Search Bar
            Spacer(minLength: 30)
            
            TextField("Search Resources", text: $searchText)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)

            // Resource List
            ScrollView {
                LazyVStack(spacing: 16) {
                    if filteredResources.isEmpty {
                        Text("No resources found.")
                            .font(.custom("Lora-Regular", size: 22))
                            .foregroundColor(.white)
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ForEach(filteredResources) { resource in
                            ResourceCard(resource: resource)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 12)
            }
        }
        .padding()
        .background(
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationTitle("Self-Care Resources")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchSelfCareResources)
    }

    // Fetch self-care resources from Firestore
    private func fetchSelfCareResources() {
        db.collection("shesbetterResources")
            .whereField("resource type", isEqualTo: "self care")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching self-care resources: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    self.selfCareResources = documents.compactMap { document in
                        try? document.data(as: ResourceItem.self)
                    }
                }
            }
    }

    // Filter resources based on search text
    private var filteredResources: [ResourceItem] {
        selfCareResources.filter { resource in
            searchText.isEmpty || resource.title.lowercased().contains(searchText.lowercased())
        }
    }
}


struct SelfCareResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        SelfCareResourcesView()
    }
}

