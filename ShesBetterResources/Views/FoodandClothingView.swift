//
//  FoodandClothingView.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 1/1/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct FoodandClothingView: View {
    @State private var searchText = ""
    @State private var foodandclothingResources: [ResourceItem] = [] // Dynamic resources fetched from Firestore
    private let db = Firestore.firestore()
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Food and Clothing Resources")
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
        .navigationTitle("Food and Clothing Resources")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchFoodandClothingResources)
    }

    // Fetch academic resources from Firestore
    private func fetchFoodandClothingResources() {
        db.collection("shesbetterResources")
            .whereField("resource type", isEqualTo: "food and clothing")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching food and clothing resources: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    self.foodandclothingResources = documents.compactMap { document in
                        try? document.data(as: ResourceItem.self)
                    }
                }
            }
    }

    // Filter resources based on search text
    private var filteredResources: [ResourceItem] {
        foodandclothingResources.filter { resource in
            searchText.isEmpty || resource.title.lowercased().contains(searchText.lowercased())
        }
    }
}

struct FoodAndClothingView_Previews: PreviewProvider {
    static var previews: some View {
        FoodandClothingView()
    }
}
