### About this project

This is a collection of two simple macros that allow dbt to delete records from source tables. This is particularly useful when you don't want to keep any invalidated records in your database.

Before you can use these macros, ensure that the role dbt uses to access your data warehouse has been granted sufficient privileges and can perform DML operations on the source tables.

To see the macros in action:

1. Configure a dbt profile with the target schema named `demo_schema`.
2. Execute `dbt debug` to ensure you can connect to your database.
3. Execute `dbt seed` to load the mock source data into your database.
4. Take a look at the data - it simulates data loaded through Fivetran, with the `_FIVETRAN_DELETED` and `_FIVETRAN_ACTIVE` columns indicating whether the record has been invalidated/deleted from the source system.
5. Execute `dbt run-operation hard_delete_loop` and take a look at the output. This macro takes the sources and conditions declared in the `sources` list and creates the necessary DML to delete invalidated records. To do so, the macro calls another macro - `hard_delete`, which composes each query individually.
6. Execute `dbt run-operation hard_delete_loop --args "{'dry_run': false}"` and take another look at the source tables - the invalidated records have been deleted.

While the `hard_delete` macro can be used on its own with the `run-operation` command, it can be tricky to pass the arguments correctly in the command itself, especially when you want to delete data from more than one source. Therefore, the `hard_delete_loop` macro handles this by having the sources and their corresponding conditions hard-coded, which also allows to version control and expand the list of sources that require hard deletions. It can also be included as a step in an ELT pipeline.

By default, both macros will only *print* the DML they create without actually executing it, unless you explicitly call the macro with `dry_run` = `false`. Keep in mind that this will **execute** destructive `DELETE` statements on your source tables, which might be irreversible - use this macro with caution!
