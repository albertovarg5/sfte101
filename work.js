let students = [];  // Array to hold registered students

function calculateGPA() {
    let scores = [
        parseFloat(document.getElementById('math').value) || 0,
        parseFloat(document.getElementById('science').value) || 0,
        parseFloat(document.getElementById('english').value) || 0,
        parseFloat(document.getElementById('socialScience').value) || 0,
        parseFloat(document.getElementById('pe').value) || 0,
        parseFloat(document.getElementById('spanish').value) || 0
    ];
    
    let total = scores.reduce((a, b) => a + b, 0);
    let percentage = total / scores.length;
    let gpa = (percentage / 100) * 4.0;

    // Display individual student's GPA
    document.getElementById('total').textContent = total.toFixed(2);
    document.getElementById('percentage').textContent = percentage.toFixed(2);
    document.getElementById('gpa').textContent = gpa.toFixed(2);

    // Get the student's name and add to the list
    let studentName = document.getElementById('studentName').value;

    if (studentName) {
        students.push({ name: studentName, gpa: gpa.toFixed(2) });
        updateStudentList();
    }
}

function updateStudentList() {
    let studentList = document.getElementById('studentList');
    studentList.innerHTML = '';  // Clear the existing list

    // Add each student to the list
    students.forEach(student => {
        let listItem = document.createElement('li');
        listItem.textContent = `${student.name} - GPA: ${student.gpa}`;
        studentList.appendChild(listItem);
    });

    // Calculate the overall class GPA and class porcetage percentage
    calculateClassGPA();
}

function calculateClassGPA() {
    if (students.length === 0) return;
    
    let totalGPA = students.reduce((sum, student) => sum + parseFloat(student.gpa), 0);
    let overallGPA = totalGPA / students.length;
    document.getElementById('classGPA').textContent = `Class GPA: ${overallGPA.toFixed(2)}`;

    // Calculate percentage of students class porcentage
    let belowAverageCount = students.filter(student => parseFloat(student.gpa) < overallGPA).length;
    let belowAveragePercentage = (belowAverageCount / students.length) * 100;
    document.getElementById('belowAveragePercentage').textContent = `Below Average: ${belowAveragePercentage.toFixed(2)}%`;
}
