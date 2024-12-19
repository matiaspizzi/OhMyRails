# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "tailwindcss", to: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
