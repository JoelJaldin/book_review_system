# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails"
pin "@hotwired/stimulus"
pin "@hotwired/stimulus-loading"
pin_all_from "app/javascript/controllers", under: "controllers"
