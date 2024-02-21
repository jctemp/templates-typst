#let address(street, city, country) = {
  (
    street: street,
    city: city,
    country: country,
  )
}

#let from(author, address, phone, email, url) = {
  (
    author: author,
    address: address,
    phone: phone,
    email: email,
    url: url,
  )
}

#let to(name, address, phone, email) = {
  (
    name: name,
    address: address,
    phone: phone,
    email: email,
  )
}

#let letter(
  // The paper print format
  paper: "a4",
  // Text size
  fontsize: 12pt,
  // The used language
  language: "en",
  // Marks on the left side for folding
  foldmarks: true,
  // The creation date of the letter
  date: datetime.today().display("[day].[month].[year]"),
  // The subject of the letter
  subject: "Betreffzeile",
  // Debug mode, colour regions for debugging
  debug: false,

  // Sender address
  from: (
    // Name of the sender to show in letterhead and url
    author: "Max Mustermann",
    // Address of the sender to show in letterhead and url
    address: (
      // Required
      street: "Musterstraße 1",
      // Required
      city: "12345 Musterstadt",
      // Optional (string)
      country: none,
    ),
    // Phone number to show in letterhead
    // Optional (string)
    phone: none,
    // E-mail to show in letterhead
    // Optional (string)
    email: none,
    // Show in letterhead
    url: true
  ),

  // Receiver address
  to: (
    // Name of the receiver to show in letterhead and url
    name: "Erica Mustermann",
    // Address of the receiver to show in letterhead and url
    address: (
      // Required
      street: "Musterallee 1",
      // Required
      city: "12345 Musterdorf",
      // Optional (string)
      country: none,
    ),
    // Phone number to show in letterhead
    // Optional (string)
    phone: none,
    // E-mail to show in letterhead
    // Optional (string)
    email: none,
  ),

  body
) = {
  set document(
    title: subject,
    author: from.author,
  )

  set page(
    paper: paper,
    margin: (
      top: 27mm,
      bottom: 16.9mm, 
      left: 25mm,
      right: 20mm,
    ),
  )

  let font-sans = "Calibri"
  let font-serif = "linux libertine"

  set text(
    lang: language, 
    size: fontsize,
    font: "calibri",
  )

  set par(
    justify: true,
  )

  // MARKS

  place(
    dx: -25mm,
    dy: 60mm,
    line(
      length: 2.5mm,
      stroke: 1pt,
    )
  )

  place(
    dx: -25mm,
    dy: 148.5mm - 27mm,
    line(
      length: 8mm,
      stroke: 1pt,
    )
  )

  place(
    dx: -25mm,
    dy: 165mm,
    line(
      length: 2.5mm,
      stroke: 1pt,
    )
  )

  // CHECKS

  if from.at("author", default: none) == none {
    panic("Author name is required and cannot be empty")
  }

  if from.at("address", default: none) == none {
    panic("Street is required and cannot be empty")
  }

  if to.at("name", default: none) == none {
    panic("Author name is required and cannot be empty")
  }

  if to.at("address", default: none) == none {
    panic("Street is required and cannot be empty")
  }

  // CONTENT

  let build_address = (address) => {
    let street = address.at("street", default: "")
    let city = address.at("city", default: "")
    let country = address.at("country", default: none)

    if street == "" {
      panic("Street is required and cannot be empty")
    }

    if city == "" {
      panic("City is required and cannot be empty")
    }

    (street, (city, country).filter(v => v != none).join(", "))
  }

  let from_address = build_address(from.address)
  let from_contact_url = (from.author, from_address.join(", "))

  let to_address = build_address(to.address)
  let to_contact = (to.name, to_address.join("\n"))

  if to.phone != none {
    to_contact.push(from.phone)
  }

  if to.email != none {
    to_contact.push(from.email)
  }

  // Receiver
  place(
    box(
      fill: luma(if debug { 240 } else { 255 }),
      width: 85mm,
      height: 45mm,
      [
        #grid(
          rows: (5mm, 12.7mm, 27.3mm),
          box(
            fill: luma(if debug { 200 } else { 255 }),
            width: 100%,
            height: 100%,
            pad(top: 1mm, text(size: 7pt, from_contact_url.join(", "))),
          ),
          [],
          to_contact.join("\n"),
        )
      ]
    )
  )

  let from_contact = (from.author, from_address.join("\n"))

  if from.phone != none {
    from_contact.push(from.phone)
  }

  if from.email != none {
    from_contact.push(from.email)
  }

  // Sender
  place(
    right,
    dy: -17mm,
    box(
      fill: luma(if debug { 200 } else { 255 }),
      width: 75mm,
      height: 62mm,
      inset: (bottom: 1em, left: 1mm, right: 1mm, top: 1mm),
      [
        #from_contact.join("\n")
      ]
    )
  )

  v(55mm)

  block(
    fill: luma(if debug { 200 } else { 255 }),
    [
        #let centering = v => align(horizon, v)
        #place(right,date)
        #v(10mm)
        #text(weight: 700,subject)
        #v(2.5mm)
        #body
    ]
  )
}
