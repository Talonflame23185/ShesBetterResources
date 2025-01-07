//
//  AcademicandEducationView.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 1/6/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct AcademicandEducationView: View {
    @State private var searchText = ""
    @State private var academicandeducationalResources: [ResourceItem] = [] // Dynamic resources fetched from Firestore
    private let db = Firestore.firestore()
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Academic and Educational Resources")
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
        .navigationTitle("Academic and Education Resources")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchFoodandClothingResources)
    }

    // Fetch academic resources from Firestore
    private func fetchFoodandClothingResources() {
        db.collection("shesbetterResources")
            .whereField("resource type", in: ["academic", "educational"])
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching academic and educational resources: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    self.academicandeducationalResources = documents.compactMap { document in
                        try? document.data(as: ResourceItem.self)
                    }
                }
            }
    }

    // Filter resources based on search text
    private var filteredResources: [ResourceItem] {
        academicandeducationalResources.filter { resource in
            searchText.isEmpty || resource.title.lowercased().contains(searchText.lowercased())
        }
    }
}

struct AcademicAndEductionView_Previews: PreviewProvider {
    static var previews: some View {
        AcademicandEducationView()
    }
}

