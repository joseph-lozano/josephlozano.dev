// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
const colors = require("tailwindcss/colors");
module.exports = {
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
  theme: {
    extend: {
      fontFamily: {
        "planet-benson-2": ["PlanetBenson2", "sans-serif"],
        mono: ["DankMono", "mono"],
      },
      colors: {
        primary: {
          50: "#E7F8F9",
          100: "#D2F1F4",
          200: "#A5E4E8",
          300: "#74D5DC",
          400: "#48C8D1",
          500: "#2DAAB3",
          600: "#24888F",
          700: "#1B656A",
          800: "#124649",
          900: "#092325",
        },
        secondary: colors.pink,
      },
    },
  },
  plugins: [require("@tailwindcss/typography"), require("@tailwindcss/forms")],
};
