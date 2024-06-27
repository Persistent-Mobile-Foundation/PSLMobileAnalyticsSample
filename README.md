<!---Licensed Materials - Property of IBM
5725-I43 (C) Copyright IBM Corp. 2016. All Rights Reserved.
US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.-->

# PSL MobileFirst Platform Foundation iOS Swift Sample Application for Analytics
Use this sample application to get started with development of iOS Swift applications.
The application uses the IBM MobileFirst SDK to connect to a local or remote server and obtain an access token and demonstrate various analytics features

**Getting Started**

1. Change directory into PSLMobileAnalyticsSample.
* Run the 'mfpdev app register' command to register the sample application on the MobileFirst Server:
  * mfpdev app register
  * Follow any prompts to include server and client application details.
* Load the PSLMobileAnalyticsSample.xcworkspace file into the XCode Development environment.
* Run the start application on either a real or virtual device from the XCode Console by
  * clicking the **Product** option
  or
  * clicking **Run**

**Updating the PMF Mobile Platform SDK**

The IBM Mobile Platform SDK files should be up-to-date. However, a Podfile has been included to update the SDKs to the latest version. To install this Podfile:

1. Change directory into MFPStarterIOSSwift.
* Run 'pod install'

