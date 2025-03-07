# ServeRest - Automated Tests 
Test Automation Project for the application **[ServeRest](https://serverest.dev/)** using **Robot Framework** with **Selenium Library**.

![Repo Size](https://img.shields.io/github/repo-size/lucas-scandido/challenge-robot-ambev?label=size&color=blue) [![Robot Framework Tests](https://github.com/lucas-scandido/challenge-robot-ambev/actions/workflows/ci.yml/badge.svg)](https://github.com/lucas-scandido/challenge-robot-ambev/actions/workflows/ci.yml)

# Prerequisites
[![Python Version](https://img.shields.io/badge/Python-3.13.1-blue)](https://www.python.org/downloads/) [![Robot Framework Version](https://img.shields.io/badge/Robot%20Framework-7.2-blue)](https://docs.robotframework.org/docs/getting_started/testing#install-robot-framework) [![ChromeDriver](https://img.shields.io/badge/ChromeDriver-134-blue)](https://googlechromelabs.github.io/chrome-for-testing/)

📝 On Windows machines, make sure to add [Python ao PATH](https://docs.python.org/3/using/windows.html#the-full-installer) during installation.

# Installation
**1. Clone the repository:**
```
git clone https://github.com/lucas-scandido/challenge-robot-ambev.git
```

**2. Navigate to the directory:**
```
cd challenge-robot-ambev
```

**3. Install the dependencies:**
- All requirements needed to execute the project are within the file `requirements.txt`.
- To facilitate installation, simply run the command `pip install -r requirements.txt`, which will install all libraries at once.

# Documentations
- **ServeRest Documentation:**
1. [API ServeRest](https://serverest.dev/)
2. [GitHub ServeRest](https://github.com/ServeRest/ServeRest)
- **Robot Documentation:**
1. [Robot Framework](https://docs.robotframework.org/)
2. [Selenium Library](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)

# Project Structure
The project structure was developed based on documentation: [Robot Framework - Project Structure](https://docs.robotframework.org/docs/examples/project_structure).

- **Folder Structure:**
```
├── .github/                                            # GitHub specific configurations, such as workflows and other GitHub Actions.   
    └── workflows                                       # CI Workflows Folder                                     
        └── ci.yml/                                     # Continuous integration configuration file
├── helpers/                                            # Helpers needed to run the tests, including fixtures and locators    
    └── fixtures/                                       # Static data files used during test execution                                    
        └── signup/                                     # Signup Fixtures    
            └── alerts.json                             # JSON file that stores all error messages from the user registration 
        └── users/                                      # Users Fixtures    
            └── response.json                           # JSON file that stores all response messages returned from the user API                                    
    └── locators/                                       # Locators used to interact with page elements                                  
        └── locators.py                                 # Python file containing the mapped locators   
├── resources/                                          # Reusable Keywords
    └── api/                                            # API Keywords
        └── users/                                      # API Users Folder
            └── users.resource                          # API Users Keywords
        └── api_common.resource                         # Common API Keywords                 
    └── e2e/                                            # E2E Keywords
        └── signup/                                     # Signup Folder
            └── signup.resource                         # Signup Keywords
        └── e2e_common.resource                         # Common E2E Keywords                                                                  
├── tests/                                              # Test Suites
    └── api/                                            # API Test Suite
        └── users/                                      # API Users Suite
            └── delete/                                 # API Users - DELETE Suite
                └── delete_invalid_users.robot          # Test Suite for Delete User With Invalid Data 
                └── delete_users.robot                  # Test Suite for Delete Users 
            └── get/                                    # API Users - GET Suite
                └── get_invalid_users.robot             # Test Suite for Search User With Invalid Data 
                └── get_users.robot                     # Test Suite for Search Users 
            └── post/                                   # API Users - POST Suite
                └── post_invalid_users.robot            # Test Suite for Create User With Invalid Data
                └── post_users.robot                    # Test Suite for Create Users
            └── put/                                    # API Users - PUT Suite
                └── put_invalid_users.robot             # Test Suite for Update User With Invalid Data
                └── put_users.robot                     # Test Suite for Update User
    └── e2e/                                            # End-to-end Test Suite
        └── signup/                                     # Signup Suite
            └── invalid_login.robot                     # Test Suite for Invalid Signup 
            └── login.robot                             # Test Suite for Valid Signup                            
├── .gitignore                                          # Files and folders should be ignored by Git  
├── README.md                                           # Project documentation      
├── requirements.txt                                    # List of dependencies needed to run the project                              
```

# Test Execution Scripts

- **Run E2E Tests:** 
```
robot -d ./logs tests/e2e/                                  # Run all the E2E tests
robot -d ./logs tests/e2e/<folder>                          # Run all the tests of a specific E2E folder
robot -d ./logs tests/e2e/<folder>/<file>.robot             # Run a specific E2E test file
```

- **Run API Tests:** 
```
robot -d ./logs tests/api/                                  # Run all the API tests
robot -d ./logs tests/api/<folder>                          # Run all the tests of a specific API folder
robot -d ./logs tests/api/<folder>/<folder>/<file>.robot    # Run a specific API test file
```