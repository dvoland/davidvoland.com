#!/usr/bin/env swift
import AppKit

let root = URL(fileURLWithPath: CommandLine.arguments[1])
let assets = root.appendingPathComponent("assets")

func color(_ hex: String, alpha: CGFloat = 1) -> NSColor {
    var value = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    if value.count == 3 {
        value = value.map { "\($0)\($0)" }.joined()
    }
    var int: UInt64 = 0
    Scanner(string: value).scanHexInt64(&int)
    let r = CGFloat((int >> 16) & 0xFF) / 255
    let g = CGFloat((int >> 8) & 0xFF) / 255
    let b = CGFloat(int & 0xFF) / 255
    return NSColor(srgbRed: r, green: g, blue: b, alpha: alpha)
}

func drawPNG(size: CGSize, url: URL, scale: CGFloat = 2, _ draw: (CGContext, CGSize) -> Void) {
    let pixel = CGSize(width: size.width * scale, height: size.height * scale)
    let image = NSImage(size: pixel)
    image.lockFocus()
    if let ctx = NSGraphicsContext.current?.cgContext {
        ctx.scaleBy(x: scale, y: scale)
        draw(ctx, size)
    }
    image.unlockFocus()
    guard let tiff = image.tiffRepresentation,
          let rep = NSBitmapImageRep(data: tiff),
          let data = rep.representation(using: .png, properties: [:]) else {
        fputs("Failed to write \(url.path)\n", stderr)
        exit(1)
    }
    try! data.write(to: url)
    print("Wrote \(url.path)")
}

func roundedRect(_ rect: CGRect, radius: CGFloat) -> NSBezierPath {
    NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
}

func drawText(_ string: String, font: NSFont, color: NSColor, origin: CGPoint) {
    let attrs: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: color
    ]
    string.draw(at: origin, withAttributes: attrs)
}

func centeredText(_ string: String, font: NSFont, color: NSColor, in rect: CGRect) {
    let attrs: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: color
    ]
    let size = string.size(withAttributes: attrs)
    let origin = CGPoint(
        x: rect.midX - size.width / 2,
        y: rect.midY - size.height / 2 - 1
    )
    string.draw(at: origin, withAttributes: attrs)
}

let paper = color("F7F4EF")
let ink = color("1C1917")
let muted = color("6B6560")
let navy = color("1C1917")

// Favicon / apple touch: rounded square, DV
func drawMonogram(size: CGSize, corner: CGFloat) {
    roundedRect(CGRect(origin: .zero, size: size), radius: corner).fill()
}

drawPNG(size: CGSize(width: 32, height: 32), url: assets.appendingPathComponent("favicon-32.png"), scale: 2) { _, size in
    color("1C1917").setFill()
    drawMonogram(size: size, corner: 8)
    let font = NSFont.systemFont(ofSize: 13, weight: .semibold)
    centeredText("DV", font: font, color: paper, in: CGRect(origin: .zero, size: size))
}

drawPNG(size: CGSize(width: 180, height: 180), url: assets.appendingPathComponent("apple-touch-icon.png"), scale: 2) { _, size in
    color("1C1917").setFill()
    drawMonogram(size: size, corner: 40)
    let font = NSFont.systemFont(ofSize: 72, weight: .semibold)
    centeredText("DV", font: font, color: paper, in: CGRect(origin: .zero, size: size))
}

func ogCard(title: String, subtitle: String, footer: String, url: URL) {
    drawPNG(size: CGSize(width: 1200, height: 630), url: url, scale: 1) { _, size in
        paper.setFill()
        NSRect(origin: .zero, size: size).fill()

        let titleFont = NSFont.systemFont(ofSize: 64, weight: .semibold)
        let subFont = NSFont.systemFont(ofSize: 28, weight: .regular)
        let footFont = NSFont.systemFont(ofSize: 22, weight: .regular)

        drawText(title, font: titleFont, color: ink, origin: CGPoint(x: 88, y: 330))
        drawText(subtitle, font: subFont, color: muted, origin: CGPoint(x: 88, y: 270))
        drawText(footer, font: footFont, color: muted, origin: CGPoint(x: 88, y: 80))
    }
}

ogCard(
    title: "David Voland",
    subtitle: "Teacher · Coach · Developer",
    footer: "davidvoland.com",
    url: assets.appendingPathComponent("og-default.png")
)

ogCard(
    title: "QuickMark: Teacher Tracker",
    subtitle: "Student Events & Follow-Ups",
    footer: "davidvoland.com/quickmark",
    url: assets.appendingPathComponent("og-quickmark.png")
)

ogCard(
    title: "Dash Timer",
    subtitle: "Track & Field, running, and workouts",
    footer: "davidvoland.com/dashtimer",
    url: assets.appendingPathComponent("og-dashtimer.png")
)
