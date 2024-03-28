/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    "app/frontend/**/*.{js,ts,css,scss,tsx,jsx}",
    './app/views/**/*',
  ],
  theme: {
    extend: { },
  },
  plugins: [require("@tailwindcss/forms"), require("@tailwindcss/typography")],
}

