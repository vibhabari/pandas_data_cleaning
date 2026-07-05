# Delta Lake Incremental Data Processing Assignment

## Objective

Perform incremental data processing using Delta Lake by loading data into a Delta table, cleaning the data, creating an incremental dataset, applying the MERGE operation, validating the results, and displaying the final dataset.


---

## Steps Performed

1. Loaded the customer master CSV into a Spark DataFrame.
2. Renamed column names to make them Delta-compatible.
3. Stored the dataset as a Delta table.
4. Performed data cleaning by handling null values and removing duplicate rows.
5. Created an incremental dataset containing:
   - 5 updated existing records
   - 5 new records
6. Applied the Delta Lake **MERGE** operation to:
   - Update existing records
   - Insert new records
7. Validated the final table by checking:
   - Total row count
8. Displayed the final Delta table.

---


## Learning Outcomes

- Understanding Delta Lake
- Incremental Data Processing
- Delta Table Creation
- MERGE Operation
- Data Cleaning using PySpark
- Data Validation in Spark

---