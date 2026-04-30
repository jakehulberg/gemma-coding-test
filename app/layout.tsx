import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Agent Task Arena",
  description: "Local-first web app for managing coding-agent tasks.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
