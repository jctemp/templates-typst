#let thesis(
  title: "",
  subtitle: "",
  degree: "",
  program: "",
  supervisor: "",
  advisor: (),
  author: "",
  submission_date: none,
  body,
) = {
  let font_size = 12pt
  let font_heading = "Linux Libertine"
  let font_body = "New Computer Modern"

  set text(
    font: "New Computer Modern",
    size: font_size,
    lang: "en"
  )

  image("./figures/wordmark_black.png", width: 10em)
  text(weight: 700, size: font_size * 2, title); linebreak()
  text(weight: 700, size: font_size * 1.5, subtitle)

  image("./figures/logo_colour.png", width: 10em)
  
}

#show: body => thesis(
  title: "A Study of the Effects of the Pandemic on the Mental Health of University Students",
  subtitle: "A Case Study of the University of Toronto",
  degree: "Master of Science",
  program: "Computer Science",
  supervisor: "Dr. John Doe",
  advisor: (
    "Dr. Jane Doe",
    "Dr. James Doe"
  ),
  submission_date: "April 2022",
  body
)