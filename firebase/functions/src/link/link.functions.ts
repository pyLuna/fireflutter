
import * as functions from "firebase-functions";
import * as express from "express";
import { getFirestore, DocumentSnapshot } from "firebase-admin/firestore";
import { AndroidCredential, AppleCredential, HtmlDeepLink } from "./link.interface";

// Initialize Express app
export const expressApp = express();

// Set up Firebase Cloud Function
export const link = functions.https.onRequest(expressApp);


/**
 * Returns the Document Snapshot
 * @param docId
 */
async function getDeeplinkDoc(docId: string): Promise<DocumentSnapshot> {
  const db = getFirestore();
  const docSnap = await db.collection("_link_").doc(docId).get();
  return docSnap;
}

expressApp.get("/.well-known/apple-app-site-association", async (req, res) => {
  const docSnaphot = await getDeeplinkDoc("apple");
  res.writeHead(200, { "Content-Type": "application/json" });
  if (docSnaphot.exists) {
    const snapshotData: AppleCredential = docSnaphot.data() as AppleCredential;
    const applinkDetails = snapshotData.apps.map((teamIDAndAppIBundled) => ({
      appID: teamIDAndAppIBundled,
      paths: ["*"],
      // appIDs: [teamIDAndAppIBundled],
    }));
    const webCredentials = snapshotData.apps.map((teamIDAndAppIBundled) => (
      teamIDAndAppIBundled
    ));
    const appsSiteAssociation = {
      applinks: {
        // apps: [],
        details: applinkDetails,
      },
      webCredentials: {
        apps: webCredentials,
      },
    };
    res.write(JSON.stringify(appsSiteAssociation));
  } else {
    // docSnap.data() will be undefined in this case
    res.write("Page not found!");
  }
  res.end();
});

expressApp.get("/.well-known/assetlinks.json", async (req, res) => {
  const docSnaphot = await getDeeplinkDoc("android");
  res.writeHead(200, { "Content-Type": "application/json" });
  if (docSnaphot.exists) {
    const snapshotData: AndroidCredential = docSnaphot.data() as AndroidCredential;
    const jsonCredentials = Object.entries(snapshotData).map(([appName, sha256s]) => ({
      relation: ["delegate_permission/common.handle_all_urls"],
      target: {
        namespace: "android_app",
        package_name: appName,
        sha256_cert_fingerprints: sha256s,
      },
    }));
    res.write(JSON.stringify(jsonCredentials));
  } else {
    // docSnap.data() will be undefined in this case
    res.write("Page not found!");
  }
  res.end();
});

const defaultHtml = `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta
      name="apple-itunes-app"
      content="app-id=#{{appleAppId}}, app-argument=#{{deepLinkUrl}}"
    />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="white" />
    <meta name="apple-mobile-web-app-title" content="#{{title}}" />

    <link rel="icon" type="image/png" href="#{{appIconLink}}" />
    <link rel="mask-icon" href="#{{maskIconSvgUrl}}" color="#ffffff" />
    <meta name="application-name" content="#{{appName}}" />

    <title>#{{title}}</title>
    <meta name="description" content="#{{description}}" />

    <meta property="og:title" content="#{{title}}" />
    <meta property="og:description" content="#{{description}}" />
    <meta property="og:image" content="#{{previewImageLink}}" />
    <meta property="og:type" content="website" />
    <meta property="og:locale" content="en_US" />

    <meta name="twitter:card" content="#{{description}}" />
    <meta name="twitter:title" content="#{{title}}" />
    <meta name="twitter:site" content="#{{webUrl}}" />
    <meta name="twitter:description" content="#{{description}}" />
    <meta name="twitter:image" content="#{{previewImageLink}}" />
    <link rel="apple-touch-icon" href="#{{appIconLink}}" />
    <style>
      .centered {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-family: Verdana, Geneva, Tahoma, sans-serif;
        color: white;
        font-size: x-large;
        text-align: center;
      }
      body {
        background-color: black;
      }
    </style>
  </head>
  <body>
    <div class="centered">
      Redirecting...
    </div>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Detect.js/2.2.2/detect.min.js"
      rossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
    <script>
      var result = detect.parse(navigator.userAgent);
      var deepLinkUrl = "#{{deepLinkUrl}}";
      var webUrl = "#{{webUrl}}";
      var appStoreUrl = "#{{appStoreUrl}}";
      var playStoreUrl = "#{{playStoreUrl}}";

      const stateTimer = setTimeout(function () {
        if (result.os.family === "iOS" && appStoreUrl.length > 0) {
          window.location.replace(appStoreUrl);
        } else if (
          result.os.family.includes("Android") &&
          playStoreUrl.length > 0
        ) {
          window.location.replace(playStoreUrl);
        } else {
          if (webUrl.length > 0) {
            window.location.replace(webUrl);
          }
        }
      }, 2000);
      window.addEventListener("visibiltychange", function () {
        clearTimeout(stateTimer);
        stateTimer = null;
        window.open("", "_self").close();
      });
      if (deepLinkUrl.length > 0) {
        location.href = deepLinkUrl;
      }
    </script>
  </body>
</html>`;

expressApp.get("*", async (req, res) => {
  const docSnaphot = await getDeeplinkDoc("html");
  if (docSnaphot.exists) {
    const htmlSnapshot = docSnaphot.data() as HtmlDeepLink;
    let htmlSource = htmlSnapshot.html ?? defaultHtml;

    // Prepare the content
    const appName = (req.query.appName ?? "") as string;
    const title = (req.query.title ?? "") as string;
    const appStoreUrl = (req.query.appStoreUrl ?? "") as string;
    const playStoreUrl = (req.query.playStoreUrl ?? "") as string;
    const webUrl = (req.query.webUrl ?? "") as string;
    const urlScheme = (req.query.urlScheme ?? "") as string;
    const appleAppId = (req.query.appleAppId ?? "") as string;
    const appIconLink = (req.query.appIconLink ?? "") as string;
    const previewImageLink = (req.query.previewImageLink ?? "") as string;
    const description = (req.query.description ?? "") as string;
    const maskIconSvgUrl = (req.query.maskIconSvgUrl ?? "") as string;

    htmlSource = htmlSource.replaceAll("#{{appName}}", appName);
    htmlSource = htmlSource.replaceAll("#{{title}}", title);
    htmlSource = htmlSource.replaceAll("#{{appStoreUrl}}", appStoreUrl);
    htmlSource = htmlSource.replaceAll("#{{playStoreUrl}}", playStoreUrl);
    htmlSource = htmlSource.replaceAll("#{{webUrl}}", webUrl);
    htmlSource = htmlSource.replaceAll("#{{deepLinkUrl}}", urlScheme.length > 0? req.query.urlScheme + "://link" + req.url: "");
    htmlSource = htmlSource.replaceAll("#{{appleAppId}}", appleAppId);
    htmlSource = htmlSource.replaceAll("#{{appIconLink}}", appIconLink);
    htmlSource = htmlSource.replaceAll("#{{previewImageLink}}", previewImageLink);
    htmlSource = htmlSource.replaceAll("#{{description}}", description);
    htmlSource = htmlSource.replaceAll("#{{maskIconSvgUrl}}", maskIconSvgUrl);

    // Return the webpage
    return res.send(htmlSource);
  }
  // Return the webpage
  return res.send("The html document not found under _link_ collection. Please refer to the documentation.");
});
