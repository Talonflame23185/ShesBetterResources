//
//  HousingandShelterView.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 1/6/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct HousingandShelterView: View {
    @State private var searchText = ""
    @State private var housingandshelterResources: [ResourceItem] = [] // Dynamic resources fetched from Firestore
    private let db = Firestore.firestore()
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Housing and Shelter Resources")
                .font(.custom("Lora-Regular", size: 35))
                .foregroundColor(Color(hex: "ffffff"))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)

            // Search Bar
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
        .navigationTitle("Housing and Shelter Resources")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchFoodandClothingResources)
    }

    // Fetch academic resources from Firestore
    private func fetchFoodandClothingResources() {
        db.collection("shesbetterResources")
            .whereField("resource type", in: ["housing", "shelter"])
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching food and clothing resources: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    self.housingandshelterResources = documents.compactMap { document in
                        try? document.data(as: ResourceItem.self)
                    }
                }
            }
    }

    // Filter resources based on search text
    private var filteredResources: [ResourceItem] {
        housingandshelterResources.filter { resource in
            searchText.isEmpty || resource.title.lowercased().contains(searchText.lowercased())
        }
    }
}

struct HousingAndShelterView_Previews: PreviewProvider {
    static var previews: some View {
        HousingandShelterView()
    }
}
