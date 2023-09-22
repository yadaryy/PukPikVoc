//
//  PukPikviewmodel.swift
//  PukPikGame
//
//  Created by Chonlada Boonanan on 3/12/2564 BE.
//

import Foundation
import Firebase

class PukPikviewmodel: ObservableObject {

    @Published var list = [vocab]()

    func fetchdata() {
        let db = Firestore.firestore()

        db.collection("normalLevel").getDocuments { snapshot, error in

            //check errors
            if error == nil { //no error

                if let snapshot = snapshot {
                    //get all the documents and create vocab
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                            //create a vocab item for each document returned
                            return vocab(id: d.documentID,
                                         eng: d["eng"] as? String ?? "",
                                         optionA: d["a"] as? String ?? "",
                                         optionB: d["b"] as? String ?? "",
                                         answer: d["answer"] as? String ?? "")

                        }
                    }
                }
            }
        }
    }

}


