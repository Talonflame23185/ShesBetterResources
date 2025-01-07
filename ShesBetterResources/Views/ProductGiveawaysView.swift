//
//  ProductGiveawaysView.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 1/6/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct ProductGiveawaysView: View {
    @State private var searchText = ""
    @State private var giveawayResources: [ResourceItem] = [] // Dynamic resources fetched from Firestore
    private let db = Firestore.firestore()

    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Product Giveaways")
                .font(.custom("Lora-Regular", size: 35))
                .foregroundColor(Color(hex: "ffffff"))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)

            // Search Bar
            Spacer(minLength: 30)
            
            TextField("Search Giveaways", text: $searchText)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)

            // Resource List
            ScrollView {
                LazyVStack(spacing: 16) {
                    if filteredResources.isEmpty {
                        Text("Product Giveaways Coming Soon!")
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
        .navigationTitle("Product Giveaways")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchSelfCareResources)
    }

    // Fetch self-care resources from Firestore
    private func fetchSelfCareResources() {
        db.collection("shesbetterResources")
            .whereField("resource type", isEqualTo: "giveaway")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching self-care resources: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    self.giveawayResources = documents.compactMap { document in
                        try? document.data(as: ResourceItem.self)
                    }
                }
            }
    }

    // Filter resources based on search text
    private var filteredResources: [ResourceItem] {
        giveawayResources.filter { resource in
            searchText.isEmpty || resource.title.lowercased().contains(searchText.lowercased())
        }
    }
}


struct ProductGiveawaysView_Previews: PreviewProvider {
    static var previews: some View {
        ProductGiveawaysView()
    }
}
