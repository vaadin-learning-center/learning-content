const fs = require("fs").promises;
const { spawn } = require("child_process");
const imageDir = "pdf-images";

async function generatePDF() {
  console.log("Copying images...");
  await fs.mkdir(imageDir);
  try {
    for (const path of await fs.readdir(".")) {
      const stat = await fs.lstat(path);
      if (path.match(/\d\d.+/) && stat.isDirectory()) {
        if ((await fs.readdir(path)).includes("images")) {
          for (const image of await fs.readdir(`${path}/images`)) {
            await fs.copyFile(
              `${path}/images/${image}`,
              `${imageDir}/${image}`
            );
          }
        }
      }
    }

    console.log("Generating PDF");
    const pdfGenerator = spawn("asciidoctor-pdf", [
      "-a",
      "pdf-theme=../00-print-assets/themes/vaadin-theme.yml",
      "-a",
      "pdf-fontsdir=../00-print-assets/fonts",
      "pdf.adoc"
    ]);

    pdfGenerator.stdout.pipe(process.stdout);

    pdfGenerator.on("exit", async () => {
      await cleanup();
      console.log("Done.");
    });
  } catch (e) {
    console.log("Failed.", e);
    await cleanup();
  }
}

async function cleanup() {
  return fs.rmdir(imageDir, { recursive: true });
}

generatePDF();
