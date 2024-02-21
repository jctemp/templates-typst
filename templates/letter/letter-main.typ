#import "letter.typ" as letter

#let from = letter.from(
  "Max Mustermann",
  letter.address(
    "Musterstraße 1",
    "12345 Musterstadt",
    "Musterland",
  ),
  "+49 123 456789",
  "max.mustermann@test.de",
  true,
)

#let to = letter.to(
  "Mrs. Mustermann",
  letter.address(
    "Musterstraße 2",
    "12345 Musterstadt",
    "Musterland",
  ),
  "+49 123 456789",
  "mustermann@company.de",
)


#show: body => letter.letter(
  paper: "a4",
  fontsize: 12pt,
  language: "en",
  foldmarks: true,
  date: datetime.today().display("[day]. [month repr:short] [year]"),
  subject: "Betreffzeile",
  debug: false,
  from: from,
  to: to,
  body
)

Dear Mrs. Mustermann,

#lorem(50)

#lorem(150)

#lorem(20)

Best regards,

#v(2em)

Max Mustermann
