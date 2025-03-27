<h1>Setting Up an Active Directory Home Lab and Using Windows PowerShell to Generate Users for Active Directory Integration</h1>

<h2>Objective:</h2>
This project aims to set up Active Directory (AD) on Windows Server 2019, and Windows 10 will be used to join the domain.
The Windows Server 2019 is set up with 2 network cards. One of the networks is set up with NAT to be able to reach the internet, and the second network is setup as host-only. So, the Windows Server will serve as a router and a gateway for Windows 10 to be able to reach the internet.

<h2>Lab Setup:</h2>
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/0695c844-bbde-436e-b3df-328dd1b8c079" />
<br><br>
The project assumes a lab environment with Windows Server 2019 and Windows 10 already installed, so we will just make some initial configuration before we begin installing AD.
This project is done with VMWare Fusion on Mac and the configurations will be similar to the VMWare Player or VMWare workstation on a Windows PC.

<h2>Setting up the network cards and interfaces.</h2>
Power off the Windows Server 2019 if running, so that the network configuration can be performed.

<h2>Step 1: Configuring the first/default network card.</h2>
On VMWare, right-click on the Windows Server machine and select “Settings”
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/acba6a8e-dd11-41f4-a54c-61ca88adce9e" />

Figure 1: Entering the settings menu for Server 2019

<br><br>
Click on the “Network Adapter” and ensure that the option “Share with my Mac” is selected. This is the same option as the NAT configuration. This is to enable the server to use the host network to connect to the internet.
See screenshot below:
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/cd1a23ec-dab7-47fb-9572-4db8ac9c9a6e" />

Figure 2: Setting network interface 1 for NAT

<br><br>
<h2>Step 2: Configuring the second network card.</h2>
Now click on “Show All” at the top to go back to the setting home page and click on “Add Device” as shown below:
<br><br>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/f5b3403a-413d-4792-a123-1a6ef14a62a7" />

Figure 3: Add device option for the network interface 2</h2>

<br><br>
Click on “Network Adapter” since we want to add another adapter for internal (Host-only) network and click on “Add” as shown below.
<br><br>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/372b7275-4dcd-4e75-9423-f05eba2b0766" />

Figure 4: Adding the second network adapter

<br><br>

Select “Private to my Mac” and then click on “Show All”

<img width="950" alt="image" src="https://github.com/user-attachments/assets/828c5649-55aa-48a1-b4e9-e2998b2af320" />

Figure 5: Configuring Network adapter 2 to private

<br><br>
Verify that the new adapter has been added as shown below:

<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/b9a1bf88-8ef2-467b-9a35-61a2d7713cfd" />

Figure 6: Settings home showing the second adapter

<br><br>
<h2>Step 3: IP Configuration and interface setup</h2>
<br><br>
Start up the Windows server and click on the network icon on the taskbar as shown with (1) below, and click the network entry from the displayed popup labelled (2) below:

<br><br>

<img width="600" alt="image" src="https://github.com/user-attachments/assets/ea0d57c0-5377-480e-9aac-fd9461b970c1" />

Figure 7: Accessing the  Ethernet settings
<br><br>

The Ethernet window opens, and you should see 2 entries. One of them should display “Connected” while the other displays “No Internet”. Click on “Change adapter options” labelled (2) in the screenshot below.
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/a5733b48-6e47-49c9-bc1b-38d0c953fc45" />

Figure 8: Changing adapter option

<br><br>
Let’s rename the adapters so they can be easily identified. 
Right-click on the network displaying connected and give it a desired name. In this case, I have renamed it to “Internet_NAT”. 
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/7a442662-e5bd-45a2-a66b-ecc6ce766fb1" /> 

Figure 9: Renaming the adapter
<br><br>
We will equally rename the other adapter, and in this case, it has been renamed to “Internal_Private” 
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/46de0ee9-5b2e-4609-8b5f-440d859b361f" />

Figure 10: Renaming the second adapter
<br><br>
Double-click on the internal network and select “Properties” as shown below
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/1be37268-7f5f-4b22-9822-f7596e0fbc63" />

Figure 11: Accessing the properties of the adapter
<br><br>
In the properties window, select IPv4 as shown below:
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/6d16c85f-bf87-41bf-9ab6-c9ee192297b4" />

Figure 12: Navigating to IPv4 settings
<br><br>
Click on “Use the following IP address” to configure manual IP settings as shown with (1) in the screenshot below:
Configure the IP addresses and in this project, the IP has been configured as shown in the screenshot – (IP: 174.16.1.1, Subnet mask: 255.255.255.0). We also set the preferred DNS server address to the loopback address of the server (127.0.0.1).
Click “OK” at the bottom once done to save the configuration, also click on “OK” on the other windows to close them and get back to the server homepage.
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/4fc9087e-2d52-454b-a19d-d3dd0b48d4a6" /> 

Figure 13: Assigning static IP

<h2>Step 4: Renaming the server computer name</h2>
<ol>
<li>Right-click on the start menu and select “Settings”.</li>
<br><br>
<img width="650" alt="image" src="https://github.com/user-attachments/assets/15a439c2-832b-4939-bc6f-fc504fcf2382" />
  
Figure 14: Accessing settings from the start menu

<li>Select “System” on the settings page.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/83a33151-fe7b-4e03-83f4-7dcb929365c9" />
 
Figure 15: System settings page

<li>Click on the “About” menu and click on the “Rename this PC” button as shown below:</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/8619a3e3-f8ce-4721-ac37-96678037f04d" />
 
Figure 16: About page showing the option for PC rename
<li>Give a desired name. “DC-2019” has been given in this case. Click the “Next” button when done.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/d19157e7-09c5-4b5b-9496-a47d3c982b77" />
 
Figure 17: Renaming the Server

<li>The server will prompt for a restart. Let it restart to apply the changes that have been made so far.</li>
</ol>
<br><br>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/022dfe44-7952-444d-b217-a7fd0f7b3b73" />
 
Figure 18: Restart prompt after rename

<h2>Step 5: Installing Active Directory</h2>
<ol>
<li>After the system restart, the server manager should automatically launch, but if it does not, just search for “Server Manger” from the start menu. When the server manager menu opens, click on “Add roles and features” from the dashboard menu.  See screenshot below:</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/fbfd818c-a7cb-48a3-9760-40189436b97c" />
 
Figure 19: Server dashboard

<li>The “Add roles and features wizard” will open, click on “Next.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/1de4ec18-35ab-494d-a74d-6e950050460a" />
 
Figure 20: Add roles and feature initialization

<li>In the Installation type page, leave the default option, which is “Role-based or feature-based installation,” and click the “Next” button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/3c1ed3e8-218f-48e0-ae4f-8291c4ed2d7d" />
 
Figure 21: Installation type selection
<li>On the “Server Selection” page, confirm that the name given to the server during computer rename is displayed correctly and is selected, and click “Next”</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/c8486a40-f70a-4bd7-96ef-706e4b45e9c8" />
 
Figure 22: Server selection page

<li>From the “Server Roles” page, be sure to tick the “Active Directory Domain Services” box.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/b650e0c9-f6e4-42ea-8d8b-70611d771205" />
 
Figure 23: Server roles selection

<li>This will open the features page, click the “Add Features” as shown below. Then click on the “Next” button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/654c9027-52d4-402f-bf60-58277f695856" />
 
Figure 24: Add features window
<li>Click on “Next” in the “Active Directory Domain Services” page.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/2b1c7966-a94e-4f6e-922a-91b6beeeedf5" />
 
Figure 25: AD DS Page

<li>The confirmation page opens, and you can click on “Install” to begin installing the Active Directory roles and features.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/1ab762e5-4576-4f19-827a-441f41198d56" />
 
Figure 26: Confirmation page

<li>Wait for the installation to finish as can be seen on the “Results” page, and click on the “Close” button to exit the page.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/87cfeb89-230a-492c-a83b-5190b674c479" />
 
Figure 27: Installation Results page
<li>After the installation, we need to complete the Active Directory setup. Click on the notification icon at the top, which will likely be displaying a yellow hazard sign notifying you to promote the server to a domain controller, as shown below:</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/3f170863-2f67-4afc-bb48-0d75ea9be362" />
 
Figure 28: Notification to promote the AD to DC
<li>This will open the “Deployment Configuration” page. Click on the “Add a new forest” radio button and fill the “Root domain name” field with a desired name. The domain name used in this project is “mydomain.com”. Click the “Next” button when done.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/e96d77a4-5a49-4a45-9fd0-d6dac73cf351" />
 
Figure 29: Adding a new forest
<li>In the domain controller options page, supply a password and click the “Next” button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/dd903a5f-e50c-4571-99c8-b8c64a81ed86" />
 
Figure 30: Domain controller options page and setting password

<li>Keep clicking the “next” button through the pages until you get to the “Prerequisites” page, where you can now click on the “Install” button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/bbb15281-ff8f-4cae-821a-8d09e966f84a" />
 
Figure 31: Prerequisite check before installation

<li>The system will prompt for a restart after the installation is completed. If it does not prompt automatically, then initiate a restart. Observe the login username after the restart and confirm that the root domain name has been added to the login name. Proceed to enter the password and sign in to the Windows server.</li>
</ol>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/27e98fde-5674-494f-b54e-742a828cad19" />
 
Figure 32: Logging into the domain
<h2>Step 5: Creating a user inside the active directory and adding the user to the admin group.</h2>
<ol>
<li>Click on the start menu and click on “Windows Administrative Tools”, then select “Active Directory Users and Computers” from the sub-menu.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/093cb264-5097-48c3-9257-3efa2b6e911a" />
 
Figure 33: Navigating to the Active Directory Users and Computers page

<li>Then, in the “Active Directory Users and Computers” page, right-click on the domain name in the left pane labelled (1) below, and click on “New”, then select “Organizational Unit” in the sub-menu.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/2b3b0664-5c30-42e3-b670-567e47da356a" />
 
Figure 34: Creating a new OU

<li>We want to create an organizational unit for admin users, so we give the organizational unit a name. In this case, “Admin_Users”. Click the “OK” button when done.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/4dcbd6e1-2a60-4a4e-9965-63d1a73a4b03" />
 
Figure 35: Giving the OU a name

<li>Observe that the domain name on the left pane automatically expands after clicking the “OK” button. Now that the admin users organizational unit has been created, we need to create an admin user that will reside in the organizational unit. So, right-click the newly created organizational unit and click on “New”, then click on “User” from the sub-menu.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/6fd7c923-543f-4488-b941-0af3e39fead3" />
 
Figure 36: Creating a new user inside an OU

<li>Fill in the important fields as shown below and then click on the “Next” button:</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/9048a702-d094-419d-b897-f3053ef42a10" />
 
Figure 37: Filling the fields required for a new user

<li>Supply a password on the next page and check the options to select as desired. For this project, we are only enabling the “Password never expires” option alone. And click the next button when done.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/173b918f-d58c-481e-b495-f07e96b0572b" />
 
Figure 38: Setting the password and options for the new user

<li>Click the “Finish” button on the last page.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/766d7f8a-2475-44ed-a2e8-c4568ca296a9" />
 
Figure 39: Finish setup for the new user
<li>You should see that the new user has now been created. Right-click on the user and select “Properties” on the context menu.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/9719807a-ab1d-4a04-96c8-099385e2a72e" />
 
Figure 40: Accessing the properties option of the new user

<li>A new window opens, click on the “Member of” tab and click on the “Add” button as seen below. This is to help us add the new user to a default domain group:</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/067de263-b69e-409d-8e3c-bb2adf6e49af" />
 
Figure 41: Adding a new user to a group

<li>The group window will display, type “domain admin” and click on the “Check Names” button which should automatically validate the group name entered. Click the “OK” button once the supplied name has been validated.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/c5d41428-a9ff-4937-83a1-99749ea4d026" />
 
Figure 42: Validating a group name before submitting

<li>Since the user has been added now, you should see the group name in the summary page. Click on the “Apply” button and the “OK” button afterwards.</li>

<img width="339" alt="image" src="https://github.com/user-attachments/assets/cf13fac3-9c8a-4e4b-81cd-4bfe2b883f60" />

Figure 43: Confirming that the user has been updated to the admin group

<li>Sign out of the current user account to be able to test the newly created Active Directory admin user. Click on the start menu and then click on the user profile icon labelled (2) below, then click on sign out.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/280ae94a-332f-4815-99b8-67039c0a653f" />
 
Figure 44: Signing out a current user

<li>Now in the logon screen, click on “Other user” (1) and enter the username of the just created admin user (2), enter the password (3) as well, and hit the enter button to sign in for the first time.</li>

</ol> 
<img width="950" alt="image" src="https://github.com/user-attachments/assets/bcfee9db-2334-49d4-8309-caf2bfd2a0dc" />

Figure 45: Login screen for the other user option

<h2>Step 6: Installing RAS/NAT</h2>

<ol>
<li>We will install RAS/NAT (Remote Access Server / Network Address Translator) on the server to enable our clients that will be on the private network to still be able to access the internet.
Go ahead to the dashboard page of the server manager and click on “Add Roles and Features” </li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/4531eaf3-f187-4c03-9bad-65e36ca31828" />
 
Figure 46: Add roles and features page
<li>Click on the “Next” button multiple times till you get to the “Server Roles” page, then click the “Remote Access” box as shown below, then click the next button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/dc9d1db5-fbf4-4848-8445-fb0f1c56ae00" />
 
Figure 47: Selecting the remote access option


<li>On the “Features” and “Remote Access” pages, leave the default settings and click Next. Then on the “Role Services” page, check the “Routing” box which will open another popup window as can be seen below.  Click on the “Add Features” button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/44a7176c-8d75-48a0-adf3-f098aed0d966" />
 
Figure 48: Adding role service features


<li>Once the “Routing” checkbox is selected, the “DirectAccess and VPN (RAS)” checkbox will also be automatically selected. Then click on the “Next” button. See the screenshot below.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/12931c34-1dda-4042-a1b5-7efdfecd81c6" />
 
Figure 49: Routing option automatically checking the RAS option


<li>Continue to click on the “Next” button till you get to the “Confirmation” page and then click on the “Install” button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/a7fe607b-fc89-44fd-88e9-26e5ecb1c4c5" />
 
Figure 50: Installation confirmation page

<li>Wait for the installation to complete and click on the “Close” button.</li>
</ol>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/fed1d906-bfed-4b5b-abc2-9517a746ec61" />
 
Figure 51: Installation result page


<h2>Step 7: Configuring RAS/NAT</h2>

<ol>
  
<li>In the server manager dashboard page, click on the “Tools” menu and select the “Routing and Remote Access” option.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/c9654cfe-bfbe-4d58-8865-fd9b19a08b62" />
 
Figure 52: Selecting Routing and Remote access option

<li>In the “Routing and Remote Access” page, simply right-click on the computer name and select the “Configure and Enable Routing and Remote Access” option.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/00a195be-e965-4141-a93a-5155cd09144c" />
 
Figure 53: Rounting and remote access home page


<li>When the “Routing and Remote Access Server Setup Wizard” comes up, hit the “Next” button. On the “Configuration” page, select the radio button for “Network address translation” and click the “Next” button at the bottom.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/8e23ac20-7573-43e0-b3e8-de496991c67c" />
 
Figure 54: RAS setup wizard

<li>In the NAT internet connection page, click on the button to “Use this public interface to connect to the internet” and make sure to select the network interface that is connected to the internet. Remember that we renamed the interfaces earlier, so just select the interface with access to the internet. In this case, it is the “Internet_NAT”. Click the next button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/8eb58b3c-1698-4e68-a510-d85a59b51fbf" />
 
Figure 55: Selecting the public interface to connect to the internet


<li>Click the finish button on the last page.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/78ddf88e-5398-4610-9fbe-897454a367c2" />
 
Figure 56: Final page of the RAS configuration


<li>Now that the setup is complete, from the “Routing and Remote Access” homepage, the play icon should have turned green. But, if it has not, simply right-click on the server name and select refresh.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/765b495e-79ab-4e54-a579-33ce5103eca7" />
 
Figure 57: Navigating the RAS home

<li>Close the window when done.</li>

</ol>

<h2>Step 8: Setting up DHCP on the DC</h2>
<ol>
<li>Navigate to the “Server Manager > Dashboard” page and click on the “Add roles and features” link. When the window opens, click on the next button and on the next page, click on the “DHCP Server” check box and click on the next button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/215c5108-25ed-4f98-ac00-90d0b093d90e" />
 
Figure 58: Selecting the DHCP option in server roles


<li>Click on the “Add Features” button in the Add Features popup window.</li>

<img width="419" alt="image" src="https://github.com/user-attachments/assets/3d1933b4-9a8e-4d57-8f94-5e18189a5cac" />
 
Figure 59: Adding features

<li>Wait for the installation to complete and click the “Close” button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/e9d1a609-b714-4c37-ab4b-a7968c29ce1f" />
 
Figure 60: Installation result page

<li>Click the “Tools” menu and select the “DHCP” option.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/4485d167-af46-4c6a-9edd-6686c4e4fa2b" />
 
Figure 61: Accessing the DHCP option from the tools menu

<li>Notice that the computer name and domain name are together, click on the drop-down by the left of the computer name together with the domain name and then right-click on the IPv4 option and select “New Scope”</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/8782cd2d-acf2-4699-8bec-12153d84ea9b" />
 
Figure 62: Adding a new scope in the DHCP wizard

<li>When the “New Scope” wizard comes up, click on the “Next” button. On the scope name wizard page, give it a desired name. We are giving it the network range name here which is 174.16.1.100-200.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/2fd55d5d-0b9c-4838-8810-317be182955e" />
 
Figure 63: Giving the new scope a name
<li>In the address range page, enter the start IP address and the end IP address which are 174.16.1.100 and 174.16.1.200, respectively. For the length, enter 24 which will automatically update the subnet mask field. Click the next button when done.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/2c3d7821-2b78-44a5-babf-7b3f41af3f43" />
 
Figure 64: Assigning IP ranges for the new scope

<li>The next page is to add IP address exclusion, but we don’t intend to configure exclusion, so click the next button to go to the lease duration page. This is used to specify the duration during which a host or client can hold on to an assigned IP address. For this project, we are setting it to 5 days. You may consider setting fewer days or even hours for a busy environment or a security conscious setting. Click on the next button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/79257953-b4c4-4f22-8409-26cc4d2c66cf" />
 
Figure 65: Setting the lease duration

<li>In the configure DHCP options page, select the “Yes, I want to configure these options now” option and click on the next button to proceed to adding the gateway. Enter a gateway and click on the add button on the right to save the address and click the next button.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/9b996829-d370-411f-a9ef-e2153a2c25e0" />
 
Figure 66: Adding a default gateway so it can act as a router

<li>In the domain name and DNS servers page, ensure that the parent domain field is populated with your domain name and that the IP address field is showing the gateway that was just added. Click the next button when done.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/79f1203f-1aa3-49b8-a8d6-6a24d2ff6ed1" />
 
Figure 67: Confirming the domain name and the gateway

<li>In the WINS server page, leave the default option as we don’t intend to make use of it. Click the next button. On the next page, select Yes to activate the scope immediately. Click next.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/ab781632-3f18-427b-a900-fb9a7a0883f8" />
 
Figure 68: Activating the scope immediately

<li>Click the finish button on the next page.</li>
<li>Back at the DHCP homepage, right-click the computer name-domain name and select “Authorize” </li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/c7cd8ca6-b822-4382-8673-8a55ffac4e87" />
 
Figure 69: Authorizing the domain to update the new settings

<li>Right-click the IPv4 and select refresh to update our settings.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/0637ecfd-b92b-477c-8a89-ead238fd2ebd" />
 
Figure 70: Refreshing the IPv4 settings

<li>This should update the settings and they should now show on the windows by the right pane as shown below:</li>

</ol>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/56ce2203-a53b-46b5-9600-9609b027517c" />

Figure 71: DHCP showing the updated information

<h2>Step 9: User creation for AD using Windows PowerShell</h2>

<b>*** Prerequisite: Download the PowerShell script using this link.</b>

<ol>
<li>Run Windows PowerShell ISE as an admin by clicking on the start menu and navigating to “Windows PowerShell > (right-click) PowerShell ISE > More > Run as administrator”. PowerShell ISE opens with 2 windows and enables us to run a script and see it as it is executing on the go. </li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/8553fe49-99d8-43b7-8edf-9484c047437d" />
 
Figure 72: Running PowerShell ISE as admin


<li>Accept the user account control check by clicking “Yes” in the dialog window. When the PowerShell ISE window opens, navigate to “File > Open”. Then select the script downloaded earlier.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/2a104af1-b289-4c3b-baad-0cf3a288e9e7" />
 
Figure 73: Opening the script downloaded earlier


<li>Execute the following command: Set-ExecutionPolicy Unrestricted and click on “Yes to all”. This is a security check for scripts that are downloaded. This script can be trusted and so, clicking “Yes to all” will allow our script to run without interruption.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/5d5336b0-f2bf-409b-b758-c0bcfdedd161" />
 
Figure 74: Setting execution policy to unrestricted

<li>It is important to run the script from the location. So, navigate to the downloaded script location with the “CD” command.  See (1) in the screenshot below. Issue the “ls” command to verify the existence of the script in the directory (3) and (4):</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/3b612128-cde6-43a7-be9b-1993030ccb5a" />
 
Figure 75: Navigating to the script directory
*** Before running the script, let’s do a summary of the key functions and variables. 
<ul>
<li>$NUMBER_OF_ACCOUNTS_TO_CREATE = 100 is used to specify the number of accounts to create and this number can be adjusted to whatever you desire. But you should note that the higher the number, the longer it will take to execute.</li>
<li>$SET_USERS_PASSWORD = "UserPass-1" sets the default password for all the users created to "UserPass-1".</li>
<li>$NEW_OU_PATH = New-ADOrganizationalUnit -Name IT_USERS -ProtectedFromAccidentalDeletion $false create a new Organization Unit named “IT_USERS” and set the protected from accidental deletion to false to enforce the flexibility to delete the OU even when there are users in it.</li>
<li>$OU_PATH = "OU=IT_USERS,DC=mydomain,DC=com" assigns the newly created OU (IT_USERS) to the variable $OU_PATH.</li>
<li>function generate-random-name() is the function to generate random names from a combination of consonants and vowels.</li>
<li>$nameLength = Get-Random -Minimum 4 -Maximum 8 is used to specify the range of the length of the generated name.</li>
<li>The try {} and catch {} block is used to attempt to add the generated user into the active directory and to handle exceptions.</li>
<li>Write-Host "Creating user: $username" -BackgroundColor Black -ForegroundColor Blue creates the user and displays the information on a black background and blue foreground.</li>
<li></li>$password = ConvertTo-SecureString $SET_USERS_PASSWORD -AsPlainText -Force converts the passwords declared before (UserPass-1) from plaintext to secure string before it can be used by Active Directory and in order to meet complexity requirements.</li>
<li>Write-Host "User $username created successfully!" -ForegroundColor Green displays a “user created successfully” message with a green foreground color.</li>
</ul>


<li>Click on the play button labelled (5) in the screenshot above to begin executing the script. Click “OK” in the dialog box that pops up, indicating that the script will be saved. The script should successfully run, and you should then see success messages for each of the users created and added successfully into the AD “IT_USERS”.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/a1f20b1d-1edb-4ab3-844a-53e5f88c47dd" />
 
Figure 76: PowerShell ISE showing that script executed successfully


<li>Verify that the users have been created and added into the active directory by clicking the start menu and navigating to “Windows Administrative Tools > Active Directory Users and Computers”</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/acaf9f4c-a046-4b82-bac3-a399d2cf5943" />
 
Figure 77: Navigating to the active directory users and computers

<li>Confirm that you can see all the newly created users in the active directory, depending on the number of users declared for creation by clicking on the domain name dropdown icon and selecting the newly created OU from our script which is “IT_USERS”. It can be seen below that the users have been created successfully. Take note of the first user (bedolil.dohona) as this will be the user we will use as test to log in to Windows 10.</li>
</ol>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/c6670881-c5e8-4b23-8e51-84b59e574a5d" />
 
Figure 78: Active directory users showing the list of newly created users


<h2>Step 10: Configuring the Network Interface of Windows 10 Client to Private.</h2>
<ol>
<li>From the VMware library, right-click on the Windows 10 machine and select settings.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/a37cab42-0874-4938-a44d-7655392c9418" />
 
Figure 79: VMWare library showing the context menu for the Windows 10 client

In the settings page, select the network adapter

<img width="950" alt="image" src="https://github.com/user-attachments/assets/21af28b1-683a-46ba-8df4-3de2585d5bb9" />
 
Figure 80: System settings for the Windows 10 machine


<li>When the options for the network adapter open, make sure to select “Private to my Mac” by clicking on the radio button. This is to ensure that the Windows 10 client is not connected to the internet by itself through this adapter, but would only be able to reach the internet through the Windows server via the RAS/NAT that has been configured on the Windows server.</li>

</ol>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/6dad0a82-12de-47b8-93e8-da95026b878c" />

Figure 81: Configuring the network interface to private


<h2>Step 11: Logging on to Windows 10 Client and checking the network properties before joining the domain.</h2>
<ol>
<li>You can confirm on that the private configuration applied to the network adapter is at work by confirming that the machine could not reach the internet. It can be immediately seen that there is no network from the network icon in the taskbar. </li>

<img width="308" alt="image" src="https://github.com/user-attachments/assets/1be33f32-be5a-41a8-8698-9852794ac673" />
 
Figure 82: Windows taskbar showing "No network" from the network icon

<li>We can dig further and see some other properties. First, let's use ipconfig to check the IP configuration. So, type ipconfig in a command prompt window by launching Command Prompt from the start menu and then typing ipconfig in the window that opens. See screenshot below.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/a4f91d70-261f-4f98-9cf1-1fcca298b786" />
 
Figure 83: Command prompt showing the result of ipconfig
<li>From the above, it can be seen that there are only limited properties. Note the IP address and also observe that there is no gateway assigned and that simply means there is no way the machine will ever be able to reach the internet.</li>

</ol>

<h2>Step 12: Logging on to Windows 10 Client and joining the domain with one of the newly generated users.</h2>
<ol>
<li>Go to your Windows 10 client machine and sign in as an existing user. Then right-click the start menu and select “Settings”. From the settings page, click the “About” link (1) at the bottom and select the “Rename this PC (Advanced) (2) at the right as shown in the screenshot below.

<img width="451" alt="image" src="https://github.com/user-attachments/assets/edf57dcf-7dc6-4b9d-aab2-44f5e7306d53" />
 
Figure 84: Navigating the Settings>About page


<li>The “System Properties” window opens. Select the “Change” option under the “Computer Name” tab. </li>

<img width="404" alt="image" src="https://github.com/user-attachments/assets/0b54d9b2-0b90-446f-a19e-d168941c17b8" />
 
Figure 85: System properties page


<li>Input the desired computer name, e.g. “WIN-10_CLIENT” as is in this case and type in the appropriate domain name like “mydomain.com” as is in this case. Click OK when done and it should automatically attempt to join the domain by requesting user credentials.</li>

 <img width="322" alt="image" src="https://github.com/user-attachments/assets/ec8023c8-30e5-40b8-97f8-fbdcc16bbe86" />

Figure 86: Renaming the computer and adding it to the domain


<li>Now enter any of the users that were created with the script earlier. In this case, we are using the first user on the list of users created previously namely “bedolil.dohona” and recall that the password we applied for the users is “UserPass-1”. So we go ahead to enter the credentials on the login screen and hit enter or click “OK”</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/073b7974-44d3-43f3-a054-d74532c9ff2d" />
 
Figure 87: Entering the new user credentials

<li>If all goes fine, you should get a welcome to the domain dialog box. Click on the OK button and you will be prompted for a restart. Click on OK to restart.</li>

<img width="309" alt="image" src="https://github.com/user-attachments/assets/15f4916d-4b11-4fd4-873a-c4c15b4235e3" />
 
Figure 88: The domain acceptance of the new user


<li>Once the Windows 10 client restarts, click on the “Other Users” link on the logon screen and enter the user credentials again to join the domain.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/ff125e57-f7e4-4fa5-8b45-233867da2476" />
 
Figure 89: Logging on to Windows with the new user credentials

<li>For the first time logging on, it will take a little time to set things up and consequently log the new user in. Wait for it to complete and load the new environment.</li>
<li>After logging in, open the command prompt and enter the “ipconfig” command to see the IP configuration.</li>
</ol>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/4a9485da-9cc5-4415-b725-c3e0859ea926" />
 
Figure 90: Using ipconfig to check the network properties of the Windows client

The screenshot above shows the assigned properties from the DHCP that we configured in the Active Directory server earlier.


<h2>Step 13: Verifying the new user who has joined the domain from the Windows Server.</h2>

<ol>
<li>Log back into the Windows server. Click on the start menu and navigate to “Administrative Properties > Active Directory Users and Computers”. Then click on the dropdown by the name of the domain in the left pane. Click on “Computers” and you should be able to see the Windows 10 client that just joined the domain on the right pane. So, as more computers are joining the domain, they will automatically be inventoried here.</li>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/c0abd7a3-1891-4951-9792-1f2925ec3c8f" />
 
Figure 91: Active directory users and computers showing the info of the computer that has successfully joined the domain
<li>Next, we can check the address leases to see the IP addresses that have been leased. In the server homepage, navigate to “Tools > DHCP”.</li>
<ul>
<li>Click on the domain dropdown (1)</li>
<li>Click on the IPv4 dropdown (2)</li>
<li>Click on the scope dropdown (3)</li>
<li>Click on the Address Leases (4)</li>
</ul>

<img width="950" alt="image" src="https://github.com/user-attachments/assets/69b136c7-9d76-43d2-b51d-2671543d176e" />
 
Figure 92: DHCP showing the address leases

As can be seen from the above, the IP 174.16.1.100 is where we configured our IP to start from when we were performing the DHCP setup. Also recall, this is the IP we found on the Windows 10 client machine when we checked the ipconfig command.

</ol>


<h2>Step 14: Verifying the network properties on the Windows 10 Client after joining the domain.</h2>
<ol>
<li>It can be immediately visibly seen from the network/ethernet icon on the taskbar that the Windows 10 client is now connected to the internet. </li>
  
<img width="272" alt="image" src="https://github.com/user-attachments/assets/72e49f3e-53b3-4f1e-8408-4b2da3585780" />
 
Figure 93: Ethernet icon on the taskbar showing machine connected to the internet

<li>Run a basic ipconfig command in the command prompt to see the network properties by opening the command prompt from the start menu and typing “ipconfig” and hitting enter. See screenshot below.</li>
</ol>
<img width="950" alt="image" src="https://github.com/user-attachments/assets/ec4dc6f3-a330-4035-be70-060f823cfdf0" />
 
Figure 94: ipconfig result from the command prompt showing the changes in the network properties

From the screenshot above, it can be deduced that the network properties have been modified which is responsible for why the Windows 10 client can now reach internet. Some of the modifications annotated above include:
<ul>
<li>(1) showing the domain change from “localdomain” previously to “mydomain.com”</li>
<li>(2) showing the IPv4 change from 172.16.136.129 previously to 176.16.1.100 which is the starting IP as configured in DHCP previously on the Windows Server.</li>
<li>(3) Showing the change in the default gateway which was blank previously, i.e. before joining the domain and now to 174.16.1.1 which is the static IP set for the IPv4 on the Internal_Private network interface on the Windows Server.</li>
</ul>

![image](https://github.com/user-attachments/assets/a7d0fa8d-8496-4bb4-8f14-60255d61b5ce)
