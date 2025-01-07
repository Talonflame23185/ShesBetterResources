//
//  ParentResourcesView.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 1/6/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct ParentResourcesView: View {
    @State private var searchText = ""
    @State private var parentResources: [ResourceItem] = [] // Dynamic resources fetched from Firestore
    private let db = Firestore.firestore()

    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Parental Resources")
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
        .navigationTitle("Parental Resources")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchSelfCareResources)
    }

    // Fetch self-care resources from Firestore
    private func fetchSelfCareResources() {
        db.collection("shesbetterResources")
            .whereField("resource type", isEqualTo: "parent")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching self-care resources: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    self.parentResources = documents.compactMap { document in
                        try? document.data(as: ResourceItem.self)
                    }
                }
            }
    }

    // Filter resources based on search text
    private var filteredResources: [ResourceItem] {
        parentResources.filter { resource in
            searchText.isEmpty || resource.title.lowercased().contains(searchText.lowercased())
        }
    }
}


struct ParentalResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ParentResourcesView()
    }
}

