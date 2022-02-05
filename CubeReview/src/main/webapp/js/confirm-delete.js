function confirmDelete(text, path) {
    if (confirm(text) == true) {
        window.location.replace(path);
    }
}
