import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var temp = ""
    
    
    

    
    @State private var textInfo = ["Poodle", "Golden Doodle"]
    
    var body: some View {
        var counter = 0
        VStack {
            Button(action: {
                self.isShowingImagePicker.toggle()
                
                if counter == 0 {
                    counter = 1
                }
                else {
                    counter = 0
                }
            }) {
                Text("Select Photo")
            }
            .padding()
            
            
            
            if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .padding()
                            
                TextField(textInfo[counter], text: $temp)
                                .padding()
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(8)
                                .padding()
                        }
            
            
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: self.$selectedImage, isPresented: self.$isShowingImagePicker)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

