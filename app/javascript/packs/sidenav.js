document.addEventListener("turbolinks:load", function() {
    // Variables
    const sidenav = document.getElementById('sidenav')
    const sidenavOverlay = document.getElementById('sidenavOverlay')
    const closeSidenavBtn = document.getElementById('closeSidenav')
    const sidenavToggleBtn = document.getElementById('sidenavToggle')

    // Functions
    function toggleSidenav() {
        if (sidenav.className === 'sidenav closed') {
            sidenav.classList.remove('closed')
            sidenav.classList.add('open')
            sidenavOverlay.classList.remove('closed')
            sidenavOverlay.classList.add('open')
        } else if (sidenav.className === 'sidenav open') {
            sidenav.classList.remove('open')
            sidenav.classList.add('closed')
            sidenavOverlay.classList.remove('open')
            sidenavOverlay.classList.add('closed')
        }
    }

    // Validates id when html is hidden
    if (sidenavToggleBtn != null) {
        sidenavToggleBtn.onclick = function() {
            toggleSidenav()
        }
    }


    closeSidenavBtn.onclick = function() {
        toggleSidenav()
    }

    sidenavOverlay.onclick = function() {
        toggleSidenav()
    }

});