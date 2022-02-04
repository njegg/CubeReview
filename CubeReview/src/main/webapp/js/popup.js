function confirmDelete() {
  let text = "Are you sure you want to delete this profile?";
  if (confirm(text) == true) {
    window.location.replace("http://www.w3schools.com")
  } else {
    text = "You canceled!";
  }
