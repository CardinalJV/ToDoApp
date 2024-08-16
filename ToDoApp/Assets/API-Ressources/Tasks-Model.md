# Tasks-Model

## C.R.U.D

----

### Méthode "Create":

// Tasks(Example Request)

curl -X POST "API-URL/Tasks" \
  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{
  "records": [
    {
      "fields": {
        "name": "Acheter du pain ",
        "lists": [
          "recyESml36WCsdbMF"
        ],
        "priority": "Aucune"
      }
    },
    {
      "fields": {
        "name": "Chercher macro",
        "lists": [
          "rec4MACc7Cdtce4gq"
        ],
        "priority": "Élevée"
      }
    }
  ]
}'

// Tasks(Example response)

{
    "records": [
        {
            "id": "recetFDyFkARTIt1u",
            "createdTime": "2024-07-16T14:19:52.000Z",
            "fields": {
                "priority": "Aucune",
                "lists": [
                    "recyESml36WCsdbMF"
                ],
                "name": "Acheter du pain "
            }
        },
        {
            "id": "rec0HRn5k5ugf3HA7",
            "createdTime": "2024-07-22T15:16:07.000Z",
            "fields": {
                "priority": "Élevée",
                "lists": [
                    "rec4MACc7Cdtce4gq"
                ],
                "name": "Chercher macro"
            }
        }
    ]
}

----

### Méthode "Read":

// Tasks(Example request)

curl "API-URL/Tasks?maxRecords=3&view=Tasks" \
  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN"
  
// Tasks(Example response)

{
    "records": [
        {
            "id": "recetFDyFkARTIt1u",
            "createdTime": "2024-07-16T14:19:52.000Z",
            "fields": {
                "priority": "Aucune",
                "lists": [
                    "recyESml36WCsdbMF"
                ],
                "name": "Acheter du pain "
            }
        },
        {
            "id": "rec0HRn5k5ugf3HA7",
            "createdTime": "2024-07-22T15:16:07.000Z",
            "fields": {
                "priority": "Élevée",
                "lists": [
                    "rec4MACc7Cdtce4gq"
                ],
                "name": "Chercher macro"
            }
        },
        {
            "id": "recDntzYLQGDsk8gM",
            "createdTime": "2024-08-09T16:21:53.000Z",
            "fields": {
                "priority": "Aucune",
                "isCompleted": true,
                "lists": [
                    "recPCXXxxblNwLPf9"
                ],
                "name": "Test 2"
            }
        }
    ],
    "offset": "itrop22hWbaAvjgKd/recDntzYLQGDsk8gM"
}

----

### Méthode "Update":

// Tasks(Example request)

curl -X PATCH "API-URL/Tasks" \
  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{
  "records": [
    {
      "id": "recetFDyFkARTIt1u",
      "fields": {
        "name": "Acheter du pain ",
        "lists": [
          "recyESml36WCsdbMF"
        ],
        "priority": "Aucune"
      }
    },
    {
      "id": "rec0HRn5k5ugf3HA7",
      "fields": {
        "name": "Chercher macro",
        "lists": [
          "rec4MACc7Cdtce4gq"
        ],
        "priority": "Élevée"
      }
    },
    {
      "id": "recDntzYLQGDsk8gM",
      "fields": {
        "name": "Test 2",
        "lists": [
          "recPCXXxxblNwLPf9"
        ],
        "priority": "Aucune",
        "isCompleted": true
      }
    }
  ]
}'

// Tasks(Example response)

{
    "records": [
        {
            "id": "recetFDyFkARTIt1u",
            "createdTime": "2024-07-16T14:19:52.000Z",
            "fields": {
                "priority": "Aucune",
                "lists": [
                    "recyESml36WCsdbMF"
                ],
                "name": "Acheter du pain "
            }
        },
        {
            "id": "rec0HRn5k5ugf3HA7",
            "createdTime": "2024-07-22T15:16:07.000Z",
            "fields": {
                "priority": "Élevée",
                "lists": [
                    "rec4MACc7Cdtce4gq"
                ],
                "name": "Chercher macro"
            }
        },
        {
            "id": "recDntzYLQGDsk8gM",
            "createdTime": "2024-08-09T16:21:53.000Z",
            "fields": {
                "priority": "Aucune",
                "isCompleted": true,
                "lists": [
                    "recPCXXxxblNwLPf9"
                ],
                "name": "Test 2"
            }
        }
    ]
}

----

### Méthode "Delete":

// Tasks(Example request)

curl -X DELETE "API-URL/Tasks" \
  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN" \
  -G \
  --data-urlencode 'records[]=recetFDyFkARTIt1u' \
  --data-urlencode 'records[]=rec0HRn5k5ugf3HA7'
  
// Tasks(Example response)

{
    "records": [
        {
            "id": "recetFDyFkARTIt1u",
            "deleted": true
        },
        {
            "id": "rec0HRn5k5ugf3HA7",
            "deleted": true
        }
    ]
}
