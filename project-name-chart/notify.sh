#!/bin/bash

WEBHOOK_URL=$1

ENVIRONMENT=$2

RELEASE_NAME=$5
RELEASE_TYPE=$7
RELEASE_DESCRIPTION=$6
RELEASE_NUMBER=${3:-"Latest Build"}

DEPLOYER=${4:-$RELEASE_REASON}
DEPLOYED_ON=$(date +"%a, %b %d %Y - %lHours %MMinutes")

DEPLOYMENT_STATUS=$8
DEPLOYMENT_ALERT_STATUS=${9:-'Good'}

if [ "${RELEASE_TYPE}" = "Schedule" ]; then
    DEPLOYER=$RELEASE_TYPE
    RELEASE_DESCRIPTION="Scheduled ${ENVIRONMENT} Deployment"
fi

curl --location --request POST "$WEBHOOK_URL" \
--header 'Content-Type: application/json' \
--data-raw '{
    "type": "message",
    "attachments": [
        {
            "contentType": "application/vnd.microsoft.card.adaptive",
            "contentUrl": null,
            "content": {
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "type": "AdaptiveCard",
                "version": "1.5",
                "body": [
                    {
                        "type": "ColumnSet",
                        "columns": [
                            {
                                "type": "Column",
                                "width": "auto",
                                "items": [
                                    {
                                        "type": "TextBlock",
                                        "text": "'"$ENVIRONMENT"'",
                                        "horizontalAlignment": "Left",
                                        "isSubtle": false,
                                        "wrap": true,
                                        "size": "ExtraLarge",
                                        "color": "'"$DEPLOYMENT_ALERT_STATUS"'"
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "type": "ColumnSet",
                        "separator": true,
                        "spacing": "Medium",
                        "columns": [
                            {
                                "type": "Column",
                                "width": "auto",
                                "items": [
                                    {
                                        "type": "TextBlock",
                                        "text": "Status",
                                        "spacing": "Small",
                                        "wrap": true,
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "Release Name",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "Release Type",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "Release Number",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "Date",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "Deployer",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "Release Comments",
                                        "spacing": "Small",
                                        "wrap": true
                                    }

                                ]
                            },
                            {
                                "type": "Column",
                                "width": "stretch",
                                "items": [
                                    {
                                        "type": "TextBlock",
                                        "text": "'"$DEPLOYMENT_STATUS"'",
                                        "horizontalAlignment": "Right",
                                        "spacing": "Small",
                                        "wrap": true,
                                        "color": "'"$DEPLOYMENT_ALERT_STATUS"'"
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "'"$RELEASE_NAME"'",
                                        "horizontalAlignment": "Right",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "'"$RELEASE_TYPE"'",
                                        "horizontalAlignment": "Right",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "'"$RELEASE_NUMBER"'",
                                        "horizontalAlignment": "Right",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "'"$DEPLOYED_ON"'",
                                        "horizontalAlignment": "Right",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "'"$DEPLOYER"'",
                                        "horizontalAlignment": "Right",
                                        "spacing": "Small",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "text": "'"$RELEASE_DESCRIPTION"'",
                                        "horizontalAlignment": "Right",
                                        "spacing": "Small",
                                        "wrap": true
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        }
    ]
}'