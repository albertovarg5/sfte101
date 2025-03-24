document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");
    const table = document.querySelector("table");
    const clock = document.getElementById("clock");
    const clockInBtn = document.getElementById("clock-in");
    const clockOutBtn = document.getElementById("clock-out");
    function updateClock() {
    const now = new Date();
    const timeString = now.toLocaleTimeString();
    clock.textContent = timeString;
    }
    setInterval(updateClock, 1000);
    updateClock();
    clockInBtn.addEventListener("click", function() {
    alert("Clocked In at " + clock.textContent);
    });
    clockOutBtn.addEventListener("click", function() {
    alert("Clocked Out at " + clock.textContent);
    });
    form.addEventListener("submit", function(event) {
    event.preventDefault();
    const name = document.getElementById("name").value;
    const position = document.getElementById("position").value;
    const department = document.getElementById("department").value;
    const email = document.getElementById("email").value;

    if (name && position && department && email) {
        const row = document.createElement("tr");
        row.innerHTML = `
        <td>${name}</td>
        <td>${position}</td>
        <td>${department}</td>
        <td>${email}</td>
        `;
        table.appendChild(row);
        form.reset();
        } else {
        alert("Please fill in all fields.");
        }
        });
        });
        