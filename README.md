# ServeRest - Automated Tests
E2E Test Automation Project for the application **[ServeRest](https://serverest.dev/)** using **Robot Framework** with **Selenium Library**.

# Prerequisites
1. **[Python](https://www.python.org/downloads/)** version: `>=3.13.1`.
2. **[Robot Framework](https://docs.robotframework.org/docs/getting_started/testing#install-robot-framework)** version: `>=7.2`.
3. **`WebDriver`** version: first, check your browser version and then download the compatible version from the **[Link](https://googlechromelabs.github.io/chrome-for-testing/)**.

📝 On Windows machines, make sure to add [Python ao PATH](https://docs.python.org/3/using/windows.html#the-full-installer) during installation.

# Installation
**1. Clone the repository:**
```
https://github.com/lucas-scandido/challenge-robot-ambev.git
```

**2. Navigate to the directory:**
```
cd challenge-robot-ambev
```

**3. Install the dependencies:**
- All requirements needed to execute the project are within the file `requirements.txt`.
- To facilitate installation, simply run the command `pip install -r requirements.txt`, which will install all libraries at once.

# Documentations
- **Documentation of the Application ServeRest:**
1. [API ServeRest](https://serverest.dev/)
2. [GitHub ServeRest](https://github.com/ServeRest/ServeRest)
- **Robot Documentation:**
1. [Robot Framework](https://docs.robotframework.org/)
2. [Selenium Library](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)

# Project Structure
The project structure was developed based on documentation: [Robot Framework - Project Structure](https://docs.robotframework.org/docs/examples/project_structure).

- **Folder Structure:**
```
├── helpers/                            # Helpers needed to run the tests, including fixtures and locators    
    └── fixtures/                       # Static data files used during test execution                                    
        └── signup/                     # Signup Fixtures    
            └── alerts.json             # JSON file that stores all error messages from the user registration                      
    └── locators/                       # Locators used to interact with page elements                                  
        └── locators.py                 # Python file containing the mapped locators   
├── resources/                          # Reusable keywords
    └── common.resource                 # Common Keywords 
    └── signup.resource                 # Signup Keywords                                                                  
├── tests/                              # Test Suites
    └── e2e/                            # End-to-end Test Suite
        └── signup/                     # Signup Suite
            └── invalid_login.robot     # Test Suite for Invalid Signup 
            └── login.robot             # Test Suite for Valid Signup                            
├── README.md                           # Project documentation      
├── .gitignore                          # Files and folders should be ignored by Git       
├── requirements.txt                    # List of dependencies needed to run the project                              
```

# Test Execution Scripts

- **Running E2E Tests:** 
```
robot -d ./logs tests/e2e/                           # Running all the E2E tests
robot -d ./logs tests/e2e/<folder>                   # Running a specific E2E test folder
robot -d ./logs tests/e2e/<folder>/<file>.robot      # Running a specific E2E test file
```