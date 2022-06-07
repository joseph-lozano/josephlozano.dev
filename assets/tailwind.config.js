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
      typography: ({ theme }) => ({
        primary: {
          css: {
            "--tw-prose-body": theme("colors.primary[800]"),
            "--tw-prose-headings": theme("colors.primary[900]"),
            "--tw-prose-lead": theme("colors.primary[700]"),
            "--tw-prose-links": theme("colors.primary[500]"),
            "--tw-prose-bold": theme("colors.primary[900]"),
            "--tw-prose-counters": theme("colors.primary[600]"),
            "--tw-prose-bullets": theme("colors.primary[400]"),
            "--tw-prose-hr": theme("colors.primary[300]"),
            "--tw-prose-quotes": theme("colors.primary[900]"),
            "--tw-prose-quote-borders": theme("colors.primary[300]"),
            "--tw-prose-captions": theme("colors.primary[700]"),
            "--tw-prose-code": theme("colors.primary[900]"),
            "--tw-prose-pre-code": theme("colors.primary[100]"),
            "--tw-prose-pre-bg": theme("colors.primary[900]"),
            "--tw-prose-th-borders": theme("colors.primary[300]"),
            "--tw-prose-td-borders": theme("colors.primary[200]"),
            "--tw-prose-invert-body": theme("colors.primary[200]"),
            "--tw-prose-invert-headings": theme("colors.white"),
            "--tw-prose-invert-lead": theme("colors.primary[300]"),
            "--tw-prose-invert-links": theme("colors.white"),
            "--tw-prose-invert-bold": theme("colors.white"),
            "--tw-prose-invert-counters": theme("colors.primary[400]"),
            "--tw-prose-invert-bullets": theme("colors.primary[600]"),
            "--tw-prose-invert-hr": theme("colors.primary[700]"),
            "--tw-prose-invert-quotes": theme("colors.primary[100]"),
            "--tw-prose-invert-quote-borders": theme("colors.primary[700]"),
            "--tw-prose-invert-captions": theme("colors.primary[400]"),
            "--tw-prose-invert-code": theme("colors.white"),
            "--tw-prose-invert-pre-code": theme("colors.primary[300]"),
            "--tw-prose-invert-pre-bg": "rgb(0 0 0 / 50%)",
            "--tw-prose-invert-th-borders": theme("colors.primary[600]"),
            "--tw-prose-invert-td-borders": theme("colors.primary[700]"),
          },
        },
      }),
    },
  },
  plugins: [require("@tailwindcss/typography"), require("@tailwindcss/forms")],
};
