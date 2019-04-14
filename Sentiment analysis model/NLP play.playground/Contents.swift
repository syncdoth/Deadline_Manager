import CreateML
import Cocoa

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/Godwithus/Desktop/mail_data1.csv"))

let (train, test) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: train, textColumn: "body", labelColumn: "score")

let eval_metrics = sentimentClassifier.evaluation(on: test)

let eval_acc = (1.0 - eval_metrics.classificationError) * 100

print("test accuracy: ", eval_acc)

let metadata = MLModelMetadata(author: "Choi Sehyun", shortDescription: "mail importance analyzer Model", version: "2.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/Godwithus/Desktop/mail_importance_analyzer2.mlmodel"), metadata: metadata)

try print(sentimentClassifier.prediction(from: "Whatsup how u doin"))
