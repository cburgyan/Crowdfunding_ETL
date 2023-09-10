# Crowdfunding_ETL

## Collaborators:<br>
Shayla Badeaux<br>
Karoly Burgyan<br>

---

## Sources:<br>
Python Tutorial. (n.d.). https://www.w3schools.com/python/<br>
Stack Overflow - Where Developers Learn, Share, & Build Careers. (n.d.). Stack Overflow. https://stackoverflow.com/<br>
Regex special characters. https://www.w3schools.com/python/python_regex.asp<br>
For guidance on For/If/Else list comprehension. June 6, 2022. https://stackoverflow.com/questions/4260280/if-else-in-a-list-comprehension<br>
Starter code given from bootcamp class and instructions<br>

***
# Creating An ETL Pipeline:
In this project, our team created an ETL pipeline for the ultimate purpose of transforming raw data in the form of .xlsx files into a functioning database with its own schema.<br>

## Creating the Category, Subcategory, Campaign, and Contacts DataFrames:

Extraction for creating the 'category', 'subcategory', 'campaign', and 'contacts' DataFrames began by reading in raw data from .xlsx files into a general DataFrame.
<ol style='list-style-type: upper-roman;'>
    <li>
        <strong>Creating the Category and Subcategory DataFrames:</strong><br>
        The 'category' and 'subcategory' DataFrames were constructed using similar procedures:<br>
        <ol style='list-style-type: upper-alpha; '>
            <li>
                Extraction 1
                <ol>
                    <li>
                        Use the general DataFrame to extract two new columns by splitting a column (‘category & sub-category’ to ‘category’ and ‘subcategory’).
                    </li>
                </ol>
            </li>
            <li>
                Transformation 1
                <ol>
                    <li>
                        Find the unique values of the 2 columns ('category' and 'subcategory') and assign those unique values to id values ('category_id' and 'subcategory_id') 
                    </li>
                    <li>
                        Create 2 DataFrames from the 2 columns’ unique values and their corresponding id (i.e. a 'category' DataFrame for the columns 'category' and 'category_id' and a 'subcategory' DataFrame for the columns 'subcategory' and 'subcategory_id') 
                    </li>
                </ol>
            </li>
            <li>
                Loading 1
                <ol>
                    <li>
                        These 2 DataFrames ('category' and 'subcategory' DataFrames) were then saved into 2 .csv files.
                    </li>
                </ol>
            </li>
        </ol>
    </li>
    <br>
    <li>
        <strong> Creating the Campaign DataFrame:</strong><br>
        The 'campaign' DataFrame was created by transformations to the general pandas.DataFrame (that still remained from creating the 'category' and 'subcategory' DataFrames):<br>
        <ol style='list-style-type: upper-alpha;'>
            <li>
                Extraction 2
                <ol>
                    <li>
                        Extraction already began when the general DataFrame was loaded in from the .xlsx file (already mentioned above).
                    </li>
                </ol>
            </li>
            <li>
                Transformation 2
                <ol>
                    <li>
                        For readability, rename the columns of general DataFrame.
                    </li>
                    <li>
                        For future data manipulation and readability, convert the datatypes of several columns from int64 to float and int64 to datetime.
                    </li>
                    <li>
                        To create foreign keys in the table to come: 
                        <ul>
                            <li>
                                Merge the category and subcategory DataFrames to the general DataFrame saving the result into a new DataFrame, 
                            </li>
                            <li>
                                Remove extraneous columns of ‘category’ and ‘subcategory’ leaving behind only the ‘category_id’ and ‘subcategory_id’ in the new DataFrame
                            </li>
                        </ul>
                    </li>
                </ol>
            </li>
            <li>
                Loading 2
                <ol>
                    <li>
                    Save this new DataFrame (the 'campaign' DataFrame) to a .csv files.
                    </li>
                </ol>
            </li>
        </ol>
    </li>
    <li>
        <strong>Creating the Contacts DataFrame:</strong><br>
        The 'contacts' DataFrame was created in a separate but similar ETL process from the DataFrames as it drew its data from a separate .xlsx file.<br>
        <ol style='list-style-type: upper-alpha;'>
            <li>
                Extraction 3
                <ol>
                    <li>
                        Extraction for creating the 'contacts' DataFrame began by reading in raw data from another .xlsx file.
                    </li>
                </ol>
            </li>
            <li>
                Transformation 3
                <ol>
                    <li>
                        Transform the initial pandas.DataFrame created from .xlsx by 1) removing the extraneous top row.
                    </li>
                    <li>
                        Reset the index.
                    </li>
                    <li>
                        Rename the column from the blank column name ‘&emsp;&emsp;&emsp;‘ to ‘contact_info’.
                    </li>
                    <li>
                        Creating a new column (‘contact_id’)  populated with data extracted from the original single column using a regular expression.
                    </li>
                    <li>
                        Change the datatype of ‘contact_id’ from ‘object’ to ‘int64’.
                    </li>
                    <li>
                        Create more columns (‘name’, and ‘email’)  populated with data extracted from the original single column using regular expressions.
                    </li>
                    <li>
                        Split the ‘name’ column to create the new columns of ‘first_name’, and ‘last_name’.
                    </li>
                    <li>
                        Remove the extraneous ‘name’ column.
                    </li>
                    <li>
                        Reorder the columns.
                    </li>
                </ol>
            </li>
            <li>
                Loading 3
                <ol>
                    <li>
                        Save this DataFrame (the 'contacts' DataFrame) to a .csv files.
                    </li>
                </ol>
            </li>
        </ol>
    </li>
</li>
</ol>

## Creating A Database From The New .CSV Data Files:

To create a database, the .csv were examined and an Entity-Relationship Diagram was synthesized which led to a schema, and database tables were constructed in postgresql, and, finally, these tables were populated with the data from the .csv files.
<ol style='list-style-type: upper-roman;'>
    <li>
        <strong>Inspecting The .csv Files And Creating The Schema And ERD:</strong><br>
        Inspecting the .csv files led to the synthesis of the following schema:<br><br>

            campaign
            --
            cf_id INT PK
            contact_id FK >- contacts.contact_id INT
            company_name VARCHAR(50)
            description VARCHAR(225)
            goal NUMERIC(10,2)
            pledged NUMERIC(10,2)
            outcome VARCHAR(50)
            backers_count INT
            country VARCHAR(50)
            currency VARCHAR(50)
            launched_date DATE
            end_date DATE
            category_id FK >- category.category_id VARCHAR(50)
            subcategory_id FK >- subcategory.subcategory_id VARCHAR(50)

            category
            --
            category_id PK VARCHAR(50)
            category VARCHAR(50)

            contacts
            --
            contact_id PK INT
            first_name VARCHAR(50)
            last_name VARCHAR(50)
            email VARCHAR(50)

            subcategory
            --
            subcategory_id PK VARCHAR(50)
            subcategory VARCHAR(50)
<br>
        which in turn led to the following ERD built in <a href="https://www.quickdatabasediagrams.com/">QuickDatabaseDiagrams.com</a>:
        <br>
        <br>
        <br>
        <img src="./Database_Files/QuickDBD-crowdfunding.png" />
    </li>
    <br>
    <li>
        <strong>Database Tables Were Constructed</strong><br>
        The following postgresql code was run in pgAdmin4:<br><br>

        --Create table schema
        CREATE TABLE "category" (
            "category_id" VARCHAR(50) PRIMARY KEY  NOT NULL,
            "category" VARCHAR(50)   NOT NULL
        );
        CREATE TABLE "contacts" (
            "contact_id" INT PRIMARY KEY  NOT NULL,
            "first_name" VARCHAR(50)   NOT NULL,
            "last_name" VARCHAR(50)   NOT NULL,
            "email" VARCHAR(50)   NOT NULL
        );
        CREATE TABLE "subcategory" (
            "subcategory_id" VARCHAR(50) PRIMARY KEY NOT NULL,
            "subcategory" VARCHAR(50)   NOT NULL
        );
        CREATE TABLE "campaign" (
            "cf_id" INT PRIMARY KEY  NOT NULL,
            "contact_id" INT   NOT NULL,
                FOREIGN KEY (contact_id) REFERENCES contacts(contact_id),
            "company_name" VARCHAR(50)   NOT NULL,
            "description" VARCHAR(225)   NOT NULL,
            "goal" NUMERIC(10,2)   NOT NULL,
            "pledged" NUMERIC(10,2)   NOT NULL,
            "outcome" VARCHAR(50)   NOT NULL,
            "backers_count" INT   NOT NULL,
            "country" VARCHAR(50)   NOT NULL,
            "currency" VARCHAR(50)   NOT NULL,
            "launched_date" DATE   NOT NULL,
            "end_date" DATE   NOT NULL,
            "category_id" VARCHAR(50)   NOT NULL,
                FOREIGN KEY (category_id) REFERENCES category(category_id),
            "subcategory_id" VARCHAR(50)   NOT NULL,
                FOREIGN KEY (subcategory_id) REFERENCES subcategory     (subcategory_id)
        );
<br>
    </li>
    <li>
        <strong>Importing Data Into The Tables:</strong><br>
        The following images show the queries used and the resulting data returned from the tables that were populated by importing the data from the .csv files:<br><br>
        Here's the 'contacts' table:
        <br>
        <br>
        <img src="./Database_Files/contactsTablePopulateWithData.png" />
        <br>
        <br>
        Here's the 'category' table:
        <br>
        <br>
        <img src="./Database_Files/categoryTablePopulateWithData.png" />
        <br>
        <br>
        Here's the 'subcategory' table:
        <br>
        <br>
        <img src="./Database_Files/subcategoryTablePopulateWithData.png" />
        <br>
        <br>
        Here's the 'campaign' table:
        <br>
        <br>
        <img src="./Database_Files/campaignTablePopulateWithData.png" />
    </li>
</ol>

So, using the ETL pipeline our team took the raw .xlsx data, extracted it, transformed, and loaded it in order to create a simple and functional database in postgresql!


