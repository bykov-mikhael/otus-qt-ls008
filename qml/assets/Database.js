function dbInit() {
    var db = LocalStorage.openDatabaseSync("dbContactList", "",
                                           "Track exercise", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql(
                        'CREATE TABLE IF NOT EXISTS CONTACTSTABLE (ContactFNAME text, ContactMName text, ContactLName text, ContactAlias text, ContactPhoneNumber text, ContactsMail text)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    }
    ;
}

function dbGetHandle() {
    try {
        var db = LocalStorage.openDatabaseSync("dbContactList", "",
                                               "Track exercise", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsert(ContactFNAME, ContactMName, ContactLName, ContactAlias, ContactPhoneNumber, ContactsMail) {
    var db = dbGetHandle()
    var rowid = 0
    db.transaction(function (tx) {
        tx.executeSql(
                    'INSERT INTO CONTACTSTABLE VALUES(?, ?, ?, ?, ?, ?)',
                    [ContactFNAME, ContactMName, ContactLName, ContactAlias, ContactPhoneNumber, ContactsMail])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid
}

function dbReadAll() {
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT ContactFNAME, ContactMName, ContactLName, ContactAlias, ContactPhoneNumber, ContactsMail FROM CONTACTSTABLE')
        for (var i = 0; i < results.rows.length; i++) {
            listModel.append({
                                 "ContactFNAME": results.rows.item(
                                                     i).ContactFNAME,
                                 "ContactMName": results.rows.item(
                                                     i).ContactMName,
                                 "ContactLName": results.rows.item(
                                                     i).ContactLName,
                                 "ContactAlias": results.rows.item(
                                                     i).ContactAlias,
                                 "ContactPhoneNumber": results.rows.item(
                                                           i).ContactPhoneNumber,
                                 "ContactsMail": results.rows.item(
                                                     i).ContactsMail
                             })
        }
    })
}
