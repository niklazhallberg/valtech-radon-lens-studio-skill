# Troubleshooting Lens Studio

If you're experiencing consistent crashes while using Lens Studio, The Troubleshooting Lens Studio Crashes guide will help you address the issue and provide recommendations for stable usage.

## Troubleshooting Steps[​**](#troubleshooting-steps "Copy to clipboard")

If you're facing crashes in Lens Studio, here are some steps to follow in order to minimize the occurrence of crashes:

1. Update Lens Studio to the Latest Version

   * Ensure you are using the most recent version of Lens Studio, as newer versions often include bug fixes and performance improvements that can help prevent crashes.
   * Visit our official download page [here](https://ar.snap.com/download) to check and install the latest version if you haven't already.

2. Update Your GPU Drivers

   * Ensure that your GPU (Graphics Processing Unit) drivers are up to date. Outdated drivers can lead to instability in Lens Studio.
   * Visit your GPU manufacturer's website and download the latest drivers for your specific graphics card model.

3. Clear Lens Studio Cache

   * Clearing the Lens Studio cache can help resolve issues related to corrupted or outdated data.
   * See below for detailed instructions on how to clear Lens Studio cache [on PC](#clearing-cache-on-pc) and cache [on macOS](#clearing-cache-on-mac)

4. Reinstall Lens Studio

   * If the problem persists, it's possible that your current installation of Lens Studio is corrupted.
   * To resolve this, uninstall Lens Studio, delete all Lens Studio folders, and then reinstall it from the official website [link](https://ar.snap.com/download).

## Recommendations for Stable Usage[​**](#recommendations-for-stable-usage "Copy to clipboard")

To prevent crashes and maintain a stable working environment in Lens Studio, consider the following recommendations:

1. Close Lens Studio When Not in Use

   * Avoid leaving Lens Studio open for extended periods without any active actions. If you're done working on your project or plan to leave your device idle for a while, save your project and close the Lens Studio application.

2. Minimize Concurrent Heavy Software Usage

   * Lens Studio is a resource-intensive application, and running multiple heavy software applications simultaneously can strain your system's resources.
   * To ensure smooth operation, avoid running resource-heavy applications alongside Lens Studio.

3. Regularly Save Your Work

   * Frequently save your Lens Studio projects to prevent data loss in case of unexpected crashes.
   * Consider using version control systems or backup solutions, such as Git, to safeguard your work.
   * Enable Auto saves. You can learn more about enabling autosaving [here](https://support.lensstudio.snapchat.com/hc/en-us/articles/360033793351).

4. Monitor System Resource Usage

   * Keep an eye on your system's resource usage (CPU, RAM, and GPU) while using Lens Studio. If you notice excessive resource consumption, close unnecessary applications to free up resources for Lens Studio.

5. Report Issues

   * If you still encounter crashes even after following these steps, we encourage you to report the issue to our Lens Studio support team using the "Report Crash" prompt that appears after the crash occurs.
   * Please note that we do not provide support for Lens Studio running on virtual machines.

## How to report an issue[​**](#how-to-report-an-issue "Copy to clipboard")

When reporting issues, provide clear and detailed information to help us understand and address the problem efficiently.

1. Include step-by-step reproduction steps, starting from the initial state of Lens Studio.
2. Whenever possible, share a simplified Lens Studio project that demonstrates the problem.
3. Ensure the example project contains the minimal components and assets necessary to replicate the issue.
4. Include instructions on how to reproduce the problem within the provided project.
5. Additionally, specify your system's hardware and software configurations, including your operating system, GPU model, CPU, RAM, and information about antivirus, firewall, or similar services that may affect Lens Studio's performance.
6. Specify whether your project is stored locally or via cloud services, as this information can help us better understand and address the problem
7. Mention the version of Lens Studio you're using.
8. Include screenshots or screen recordings that visually illustrate the issue.
9. Provide any error messages, warnings, or logs related to the issue, along with error codes or messages displayed within Lens Studio.
10. Indicate how frequently the issue occurs (e.g., always, occasionally, after specific actions).
11. Mention any contextual information that might be relevant (e.g., network conditions, third-party plugins).

By following these troubleshooting steps and adopting these recommendations, you can work more effectively with Lens Studio while minimizing the risk of crashes. If you encounter any further issues or have additional questions, don't hesitate to reach out to our Lens Studio support team for assistance at <lensstudio-support@snapchat.com>

## Clearing Lens Studio Cache[​**](#clearing-lens-studio-cache "Copy to clipboard")

Clearing your cache is helpful for solving issues when Lens Studio doesn't start up properly or when an issue persists after reinstalling Lens Studio. Steps for PC can be found here.

### Clearing Cache on PC[​**](#clearing-cache-on-pc "Copy to clipboard")

1. Close Lens Studio if it is open
2. Copy this address `%appdata%\snap` into the Windows search bar and press enter.
3. Delete the Lens Studio folder found there.
4. Copy this address `%localappdata%\snap` into the Windows search bar and press enter.
5. Delete the Lens Studio folder found there.
6. Re-open Lens Studio and verify if your issue persists.

### Clearing Cache on Mac[​**](#clearing-cache-on-mac "Copy to clipboard")

1. Close Lens Studio.
2. Open Finder, navigate to the menu bar and choose  `Go > Go to Folder...`.
3. Copy `~/Library/Preferences` into the prompt and press `Go`.
4. Locate the file starting with `com.Snap.LensStudio` and move it to trash.
5. Repeat steps 2-4 to Navigate to `~/Library/Caches/Snap` and delete Lens Studio folder found there.
6. Re-open Lens Studio and verify if your issue persists.

## Clearing My Lenses Credentials[​**](#clearing-my-lenses-credentials "Copy to clipboard")

Clearing your cached credentials can help solve issues with publishing, the Asset Library, or accessing the My Lenses site. Note: you will need to log back into My Lenses before you can publish Lenses again.

### Steps for PC[​**](#steps-for-pc "Copy to clipboard")

1. Close Lens Studio.
2. Open `Credential Manager`.
   <!-- -->
   * Credential Manager can be found by typing `Credential Manager"` into the Windows search bar and open the application.
3. Delete any entries starting with `com.Snap.LensStudio` by clicking on them and choosing Remove.
4. Re-open Lens Studio and verify if your issue persists.

### Steps for Mac[​**](#steps-for-mac "Copy to clipboard")

1. Close Lens Studio.
2. Open `Keychain Access`.
   <!-- -->
   * Keychain Access can be found in `Applications > Utilities > Keychain Access` or by typing `Keychain Access` into Spotlight (⌘ + space).
3. Right click any entry that starts with `com.Snap.LensStudio` and choose `Delete`.
4. Re-open Lens Studio and verify if your issue persists.

## Issues Regarding "long paths" on PC[​**](#issues-regarding-long-paths-on-pc "Copy to clipboard")

If Lens Studio is reporting issues with "long paths" on your Windows machine, you might need to enable Long-Path Support.

Refer to the following [Windows guide on enabling long paths](https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=registry#enable-long-paths-in-windows-10-version-1607-and-later).

## Plugins, or Presets are Missing[​**](#plugins-or-presets-are-missing "Copy to clipboard")

If you are running into issues with pre-installed plugins not working as expected, you may need to do the following:

1. Open the `Lens Studio` menu and choose `Preferences`.
2. Select the `Plugin` tab, and in the `Installed Plugins` section, make sure the plugin you are looking for are enaled.

If you are still having issues, you can clear the Plugins cache to re-install them.

1. Close studio.

2. Remove `~/Library/Preferences/Snap/Lens Studio/Bundle/Plugins`.

3. Remove the plugins folder:

   <!-- -->

   * Mac: `~/Library/Preferences/Snap/Lens Studio/Bundle/Plugins`
   * PC: `%localappdata%\Snap\Lens Studio\Bundle\Plugins`

4. Open studio.

If after following the above issue you are still missing any expected plugins from some panel, you may need to close and re-open this panel.
