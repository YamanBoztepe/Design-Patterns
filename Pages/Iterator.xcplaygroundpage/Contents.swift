import Foundation

struct Student {
    let name: String
}

struct Students {
    let students: [Student]
}

struct StudentIterator: IteratorProtocol {
    private var index = 0
    private let students: [Student]
    
    init(students: [Student]) {
        self.students = students
    }
    
    mutating func next() -> Student? {
        defer { index += 1 }
        return students.count > index ? students[index] : nil
    }
}

extension Students: Sequence {
    func makeIterator() -> StudentIterator {
        return StudentIterator(students: students)
    }
}

// MARK: - Usage
let students = Students(students: [Student(name: "Yaman"), Student(name: "Mehmet")])

for student in students {
    print(student.name)
}
