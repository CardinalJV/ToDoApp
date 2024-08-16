# Lists-Model

## C.R.U.D

----

### Méthode "Create":

// Lists(Example request)

curl -X POST "API-URL/Lists" \
  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{
  "records": [
    {
      "fields": {
        "title": "Aujourd'\''hui",
        "tasks": [
          "recetFDyFkARTIt1u"
        ],
        "picture": "calendar.circle.fill",
        "pictureColor": "blue"
      }
    },
    {
      "fields": {
        "title": "Programmés",
        "tasks": [
          "rec0HRn5k5ugf3HA7"
        ],
        "picture": "calendar.circle.fill",
        "pictureColor": "red"
      }
    }
  ]
}'

// Lists(Example response)

{
    "records": [
        {
            "id": "recyESml36WCsdbMF",
            "createdTime": "2024-07-17T13:01:19.000Z",
            "fields": {
                "tasks": [
                    "recetFDyFkARTIt1u"
                ],
                "title": "Aujourd'hui",
                "picture": "calendar.circle.fill",
                "pictureColor": "blue",
                "itemCount": 1
            }
        },
        {
            "id": "rec4MACc7Cdtce4gq",
            "createdTime": "2024-07-17T13:01:19.000Z",
            "fields": {
                "tasks": [
                    "rec0HRn5k5ugf3HA7"
                ],
                "title": "Programmés",
                "picture": "calendar.circle.fill",
                "pictureColor": "red",
                "itemCount": 1
            }
        }
    ]
}

----

### Méthode "Read":

// Lists(Example request)

curl "API-URL/Lists?maxRecords=3&view=Lists" \
  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN"
  
// Lists(Example response)

{
    "records": [
        {
            "id": "recyESml36WCsdbMF",
            "createdTime": "2024-07-17T13:01:19.000Z",
            "fields": {
                "tasks": [
                    "recetFDyFkARTIt1u"
                ],
                "title": "Aujourd'hui",
                "picture": "calendar.circle.fill",
                "pictureColor": "blue",
                "itemCount": 1
            }
        },
        {
            "id": "rec4MACc7Cdtce4gq",
            "createdTime": "2024-07-17T13:01:19.000Z",
            "fields": {
                "tasks": [
                    "rec0HRn5k5ugf3HA7"
                ],
                "title": "Programmés",
                "picture": "calendar.circle.fill",
                "pictureColor": "red",
                "itemCount": 1
            }
        },
        {
            "id": "recGS564TBpK04IdF",
            "createdTime": "2024-07-26T15:57:37.000Z",
            "fields": {
                "tasks": [
                    "recFSaWJUGxlOxDbE"
                ],
                "title": "liste ",
                "picture": "calendar.circle.fill",
                "pictureColor": "orange",
                "itemCount": 1
            }
        }
    ],
    "offset": "itrop22hWbaAvjgKd/recGS564TBpK04IdF"
}
  
----

### Méthode "Update":

// Lists(Example request)

curl -X PATCH "API-URL/Lists" \
  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{
  "records": [
    {
      "id": "recyESml36WCsdbMF",
      "fields": {
        "title": "Aujourd'\''hui",
        "tasks": [
          "recetFDyFkARTIt1u"
        ],
        "picture": "calendar.circle.fill",
        "pictureColor": "blue"
      }
    },
    {
      "id": "rec4MACc7Cdtce4gq",
      "fields": {
        "title": "Programmés",
        "tasks": [
          "rec0HRn5k5ugf3HA7"
        ],
        "picture": "calendar.circle.fill",
        "pictureColor": "red"
      }
    },
    {
      "id": "recGS564TBpK04IdF",
      "fields": {
        "title": "liste ",
        "tasks": [
          "recFSaWJUGxlOxDbE"
        ],
        "picture": "calendar.circle.fill",
        "pictureColor": "orange"
      }
    }
  ]
}'

// Lists(Example response)

{
    "records": [
        {
            "id": "recyESml36WCsdbMF",
            "createdTime": "2024-07-17T13:01:19.000Z",
            "fields": {
                "tasks": [
                    "recetFDyFkARTIt1u"
                ],
                "title": "Aujourd'hui",
                "picture": "calendar.circle.fill",
                "pictureColor": "blue",
                "itemCount": 1
            }
        },
        {
            "id": "rec4MACc7Cdtce4gq",
            "createdTime": "2024-07-17T13:01:19.000Z",
            "fields": {
                "tasks": [
                    "rec0HRn5k5ugf3HA7"
                ],
                "title": "Programmés",
                "picture": "calendar.circle.fill",
                "pictureColor": "red",
                "itemCount": 1
            }
        },
        {
            "id": "recGS564TBpK04IdF",
            "createdTime": "2024-07-26T15:57:37.000Z",
            "fields": {
                "tasks": [
                    "recFSaWJUGxlOxDbE"
                ],
                "title": "liste ",
                "picture": "calendar.circle.fill",
                "pictureColor": "orange",
                "itemCount": 1
            }
        }
    ]
}

----

### Méthode "Delete":

// Lists(Example request)

curl -X DELETE "API-URL/Lists" \
  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN" \
  -G \
  --data-urlencode 'records[]=recyESml36WCsdbMF' \
  --data-urlencode 'records[]=rec4MACc7Cdtce4gq'
  
// Lists(Example response)

{
    "records": [
        {
            "id": "recyESml36WCsdbMF",
            "deleted": true
        },
        {
            "id": "rec4MACc7Cdtce4gq",
            "deleted": true
        }
    ]
}
