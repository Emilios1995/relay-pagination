{ allowUnknownFields = True
, allowUnknownTypes = False
, description = Some
    "Flat repository-owned architecture decisions with stable ADR handles."
, frontmatter =
  { optional =
    [ { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Any
      , description = Some "Earlier ADR handles replaced by this decision."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "supersedes"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference = Some
        { allowLocal = True
        , allowSelf = False
        , externalUriPattern = None Text
        , externalUriSchemes = [ "mori" ]
        , localPrefix = "ADR"
        }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Scalar
      , description = Some "Later ADR handle replacing this decision."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "supersededBy"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference = Some
        { allowLocal = True
        , allowSelf = False
        , externalUriPattern = None Text
        , externalUriSchemes = [ "mori" ]
        , localPrefix = "ADR"
        }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Scalar
      , description = Some "Plan that produced the decision, when recorded."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "originatingPlan"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Any
      , description = Some
          "§5.2. Independent confirmations that this decision record is accurate."
      , elementFields = Some
        { optional =
            [] : List
                   { allowedValues : List Text
                   , cardinality : < Any | List | Scalar >
                   , description : Optional Text
                   , field : Text
                   , format :
                       Optional
                         < Actor
                         | Boolean
                         | Date
                         | DocumentHandle : Text
                         | HumanActor
                         | Integer
                         | NonNegativeInteger
                         | Rfc3339Utc
                         | Uri
                         | UriWithScheme : Text
                         >
                   , path :
                       Optional
                         { allowSelf : Bool, externalUriSchemes : List Text }
                   , reference :
                       Optional
                         { allowLocal : Bool
                         , allowSelf : Bool
                         , externalUriPattern : Optional Text
                         , externalUriSchemes : List Text
                         , localPrefix : Text
                         }
                   , when : Optional { field : Text, hasValue : List Text }
                   }
        , recommended =
          [ { allowedValues = [] : List Text
            , cardinality = < Any | List | Scalar >.Any
            , description = Some
                "UTC RFC3339 timestamp, ending in `Z`, for when this happened."
            , field = "at"
            , format = Some
                < Actor
                | Boolean
                | Date
                | DocumentHandle : Text
                | HumanActor
                | Integer
                | NonNegativeInteger
                | Rfc3339Utc
                | Uri
                | UriWithScheme : Text
                >.Rfc3339Utc
            , path = None { allowSelf : Bool, externalUriSchemes : List Text }
            , reference =
                None
                  { allowLocal : Bool
                  , allowSelf : Bool
                  , externalUriPattern : Optional Text
                  , externalUriSchemes : List Text
                  , localPrefix : Text
                  }
            , when = None { field : Text, hasValue : List Text }
            }
          ]
        , required =
          [ { allowedValues = [] : List Text
            , cardinality = < Any | List | Scalar >.Any
            , description = Some
                "§7. The actor responsible: `<producer>/<version>`, `human:<id>`, or `process:<id>`."
            , field = "by"
            , format = Some
                < Actor
                | Boolean
                | Date
                | DocumentHandle : Text
                | HumanActor
                | Integer
                | NonNegativeInteger
                | Rfc3339Utc
                | Uri
                | UriWithScheme : Text
                >.Actor
            , path = None { allowSelf : Bool, externalUriSchemes : List Text }
            , reference =
                None
                  { allowLocal : Bool
                  , allowSelf : Bool
                  , externalUriPattern : Optional Text
                  , externalUriSchemes : List Text
                  , localPrefix : Text
                  }
            , when = None { field : Text, hasValue : List Text }
            }
          ]
        }
      , field = "verified"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields = Some
        { optional =
            [] : List
                   { allowedValues : List Text
                   , cardinality : < Any | List | Scalar >
                   , description : Optional Text
                   , field : Text
                   , format :
                       Optional
                         < Actor
                         | Boolean
                         | Date
                         | DocumentHandle : Text
                         | HumanActor
                         | Integer
                         | NonNegativeInteger
                         | Rfc3339Utc
                         | Uri
                         | UriWithScheme : Text
                         >
                   , path :
                       Optional
                         { allowSelf : Bool, externalUriSchemes : List Text }
                   , reference :
                       Optional
                         { allowLocal : Bool
                         , allowSelf : Bool
                         , externalUriPattern : Optional Text
                         , externalUriSchemes : List Text
                         , localPrefix : Text
                         }
                   , when : Optional { field : Text, hasValue : List Text }
                   }
        , recommended =
          [ { allowedValues = [] : List Text
            , cardinality = < Any | List | Scalar >.Any
            , description = Some
                "UTC RFC3339 timestamp, ending in `Z`, for when this happened."
            , field = "at"
            , format = Some
                < Actor
                | Boolean
                | Date
                | DocumentHandle : Text
                | HumanActor
                | Integer
                | NonNegativeInteger
                | Rfc3339Utc
                | Uri
                | UriWithScheme : Text
                >.Rfc3339Utc
            , path = None { allowSelf : Bool, externalUriSchemes : List Text }
            , reference =
                None
                  { allowLocal : Bool
                  , allowSelf : Bool
                  , externalUriPattern : Optional Text
                  , externalUriSchemes : List Text
                  , localPrefix : Text
                  }
            , when = None { field : Text, hasValue : List Text }
            }
          ]
        , required =
          [ { allowedValues = [] : List Text
            , cardinality = < Any | List | Scalar >.Any
            , description = Some
                "§7. The actor responsible: `<producer>/<version>`, `human:<id>`, or `process:<id>`."
            , field = "by"
            , format = Some
                < Actor
                | Boolean
                | Date
                | DocumentHandle : Text
                | HumanActor
                | Integer
                | NonNegativeInteger
                | Rfc3339Utc
                | Uri
                | UriWithScheme : Text
                >.Actor
            , path = None { allowSelf : Bool, externalUriSchemes : List Text }
            , reference =
                None
                  { allowLocal : Bool
                  , allowSelf : Bool
                  , externalUriPattern : Optional Text
                  , externalUriSchemes : List Text
                  , localPrefix : Text
                  }
            , when = None { field : Text, hasValue : List Text }
            }
          ]
        }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Any
      , description = Some
          "Superseded v0.1 revision timestamp. Prefer `generated.at`."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "timestamp"
      , format = Some
          < Actor
          | Boolean
          | Date
          | DocumentHandle : Text
          | HumanActor
          | Integer
          | NonNegativeInteger
          | Rfc3339Utc
          | Uri
          | UriWithScheme : Text
          >.Rfc3339Utc
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    ]
  , recommended =
      [] : List
             { allowedValues : List Text
             , cardinality : < Any | List | Scalar >
             , description : Optional Text
             , elementFields :
                 Optional
                   { optional :
                       List
                         { allowedValues : List Text
                         , cardinality : < Any | List | Scalar >
                         , description : Optional Text
                         , field : Text
                         , format :
                             Optional
                               < Actor
                               | Boolean
                               | Date
                               | DocumentHandle : Text
                               | HumanActor
                               | Integer
                               | NonNegativeInteger
                               | Rfc3339Utc
                               | Uri
                               | UriWithScheme : Text
                               >
                         , path :
                             Optional
                               { allowSelf : Bool
                               , externalUriSchemes : List Text
                               }
                         , reference :
                             Optional
                               { allowLocal : Bool
                               , allowSelf : Bool
                               , externalUriPattern : Optional Text
                               , externalUriSchemes : List Text
                               , localPrefix : Text
                               }
                         , when :
                             Optional { field : Text, hasValue : List Text }
                         }
                   , recommended :
                       List
                         { allowedValues : List Text
                         , cardinality : < Any | List | Scalar >
                         , description : Optional Text
                         , field : Text
                         , format :
                             Optional
                               < Actor
                               | Boolean
                               | Date
                               | DocumentHandle : Text
                               | HumanActor
                               | Integer
                               | NonNegativeInteger
                               | Rfc3339Utc
                               | Uri
                               | UriWithScheme : Text
                               >
                         , path :
                             Optional
                               { allowSelf : Bool
                               , externalUriSchemes : List Text
                               }
                         , reference :
                             Optional
                               { allowLocal : Bool
                               , allowSelf : Bool
                               , externalUriPattern : Optional Text
                               , externalUriSchemes : List Text
                               , localPrefix : Text
                               }
                         , when :
                             Optional { field : Text, hasValue : List Text }
                         }
                   , required :
                       List
                         { allowedValues : List Text
                         , cardinality : < Any | List | Scalar >
                         , description : Optional Text
                         , field : Text
                         , format :
                             Optional
                               < Actor
                               | Boolean
                               | Date
                               | DocumentHandle : Text
                               | HumanActor
                               | Integer
                               | NonNegativeInteger
                               | Rfc3339Utc
                               | Uri
                               | UriWithScheme : Text
                               >
                         , path :
                             Optional
                               { allowSelf : Bool
                               , externalUriSchemes : List Text
                               }
                         , reference :
                             Optional
                               { allowLocal : Bool
                               , allowSelf : Bool
                               , externalUriPattern : Optional Text
                               , externalUriSchemes : List Text
                               , localPrefix : Text
                               }
                         , when :
                             Optional { field : Text, hasValue : List Text }
                         }
                   }
             , field : Text
             , format :
                 Optional
                   < Actor
                   | Boolean
                   | Date
                   | DocumentHandle : Text
                   | HumanActor
                   | Integer
                   | NonNegativeInteger
                   | Rfc3339Utc
                   | Uri
                   | UriWithScheme : Text
                   >
             , objectFields :
                 Optional
                   { optional :
                       List
                         { allowedValues : List Text
                         , cardinality : < Any | List | Scalar >
                         , description : Optional Text
                         , field : Text
                         , format :
                             Optional
                               < Actor
                               | Boolean
                               | Date
                               | DocumentHandle : Text
                               | HumanActor
                               | Integer
                               | NonNegativeInteger
                               | Rfc3339Utc
                               | Uri
                               | UriWithScheme : Text
                               >
                         , path :
                             Optional
                               { allowSelf : Bool
                               , externalUriSchemes : List Text
                               }
                         , reference :
                             Optional
                               { allowLocal : Bool
                               , allowSelf : Bool
                               , externalUriPattern : Optional Text
                               , externalUriSchemes : List Text
                               , localPrefix : Text
                               }
                         , when :
                             Optional { field : Text, hasValue : List Text }
                         }
                   , recommended :
                       List
                         { allowedValues : List Text
                         , cardinality : < Any | List | Scalar >
                         , description : Optional Text
                         , field : Text
                         , format :
                             Optional
                               < Actor
                               | Boolean
                               | Date
                               | DocumentHandle : Text
                               | HumanActor
                               | Integer
                               | NonNegativeInteger
                               | Rfc3339Utc
                               | Uri
                               | UriWithScheme : Text
                               >
                         , path :
                             Optional
                               { allowSelf : Bool
                               , externalUriSchemes : List Text
                               }
                         , reference :
                             Optional
                               { allowLocal : Bool
                               , allowSelf : Bool
                               , externalUriPattern : Optional Text
                               , externalUriSchemes : List Text
                               , localPrefix : Text
                               }
                         , when :
                             Optional { field : Text, hasValue : List Text }
                         }
                   , required :
                       List
                         { allowedValues : List Text
                         , cardinality : < Any | List | Scalar >
                         , description : Optional Text
                         , field : Text
                         , format :
                             Optional
                               < Actor
                               | Boolean
                               | Date
                               | DocumentHandle : Text
                               | HumanActor
                               | Integer
                               | NonNegativeInteger
                               | Rfc3339Utc
                               | Uri
                               | UriWithScheme : Text
                               >
                         , path :
                             Optional
                               { allowSelf : Bool
                               , externalUriSchemes : List Text
                               }
                         , reference :
                             Optional
                               { allowLocal : Bool
                               , allowSelf : Bool
                               , externalUriPattern : Optional Text
                               , externalUriSchemes : List Text
                               , localPrefix : Text
                               }
                         , when :
                             Optional { field : Text, hasValue : List Text }
                         }
                   }
             , path :
                 Optional { allowSelf : Bool, externalUriSchemes : List Text }
             , reference :
                 Optional
                   { allowLocal : Bool
                   , allowSelf : Bool
                   , externalUriPattern : Optional Text
                   , externalUriSchemes : List Text
                   , localPrefix : Text
                   }
             , uniqueBy : Optional Text
             , when : Optional { field : Text, hasValue : List Text }
             }
  , required =
    [ { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Scalar
      , description = Some "The Architecture Decision Record concept type."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "type"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Scalar
      , description = Some "Decision title without the ADR number."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "title"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Scalar
      , description = Some "Bundle-scoped stable ADR-N handle."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "docId"
      , format = Some
          ( < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >.DocumentHandle
              "ADR"
          )
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Scalar
      , description = Some "Repository-native decision status."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "status"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Scalar
      , description = Some "Original calendar date of the decision."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "date"
      , format = Some
          < Actor
          | Boolean
          | Date
          | DocumentHandle : Text
          | HumanActor
          | Integer
          | NonNegativeInteger
          | Rfc3339Utc
          | Uri
          | UriWithScheme : Text
          >.Date
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Scalar
      , description = Some "One-sentence summary of the decision."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "description"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    , { allowedValues = [] : List Text
      , cardinality = < Any | List | Scalar >.Any
      , description = Some
          "§5.2. Who produced this decision record's current content, and when."
      , elementFields =
          None
            { optional :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , recommended :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            , required :
                List
                  { allowedValues : List Text
                  , cardinality : < Any | List | Scalar >
                  , description : Optional Text
                  , field : Text
                  , format :
                      Optional
                        < Actor
                        | Boolean
                        | Date
                        | DocumentHandle : Text
                        | HumanActor
                        | Integer
                        | NonNegativeInteger
                        | Rfc3339Utc
                        | Uri
                        | UriWithScheme : Text
                        >
                  , path :
                      Optional
                        { allowSelf : Bool, externalUriSchemes : List Text }
                  , reference :
                      Optional
                        { allowLocal : Bool
                        , allowSelf : Bool
                        , externalUriPattern : Optional Text
                        , externalUriSchemes : List Text
                        , localPrefix : Text
                        }
                  , when : Optional { field : Text, hasValue : List Text }
                  }
            }
      , field = "generated"
      , format =
          None
            < Actor
            | Boolean
            | Date
            | DocumentHandle : Text
            | HumanActor
            | Integer
            | NonNegativeInteger
            | Rfc3339Utc
            | Uri
            | UriWithScheme : Text
            >
      , objectFields = Some
        { optional =
            [] : List
                   { allowedValues : List Text
                   , cardinality : < Any | List | Scalar >
                   , description : Optional Text
                   , field : Text
                   , format :
                       Optional
                         < Actor
                         | Boolean
                         | Date
                         | DocumentHandle : Text
                         | HumanActor
                         | Integer
                         | NonNegativeInteger
                         | Rfc3339Utc
                         | Uri
                         | UriWithScheme : Text
                         >
                   , path :
                       Optional
                         { allowSelf : Bool, externalUriSchemes : List Text }
                   , reference :
                       Optional
                         { allowLocal : Bool
                         , allowSelf : Bool
                         , externalUriPattern : Optional Text
                         , externalUriSchemes : List Text
                         , localPrefix : Text
                         }
                   , when : Optional { field : Text, hasValue : List Text }
                   }
        , recommended =
          [ { allowedValues = [] : List Text
            , cardinality = < Any | List | Scalar >.Any
            , description = Some
                "UTC RFC3339 timestamp, ending in `Z`, for when this happened."
            , field = "at"
            , format = Some
                < Actor
                | Boolean
                | Date
                | DocumentHandle : Text
                | HumanActor
                | Integer
                | NonNegativeInteger
                | Rfc3339Utc
                | Uri
                | UriWithScheme : Text
                >.Rfc3339Utc
            , path = None { allowSelf : Bool, externalUriSchemes : List Text }
            , reference =
                None
                  { allowLocal : Bool
                  , allowSelf : Bool
                  , externalUriPattern : Optional Text
                  , externalUriSchemes : List Text
                  , localPrefix : Text
                  }
            , when = None { field : Text, hasValue : List Text }
            }
          ]
        , required =
          [ { allowedValues = [] : List Text
            , cardinality = < Any | List | Scalar >.Any
            , description = Some
                "§7. The actor responsible: `<producer>/<version>`, `human:<id>`, or `process:<id>`."
            , field = "by"
            , format = Some
                < Actor
                | Boolean
                | Date
                | DocumentHandle : Text
                | HumanActor
                | Integer
                | NonNegativeInteger
                | Rfc3339Utc
                | Uri
                | UriWithScheme : Text
                >.Actor
            , path = None { allowSelf : Bool, externalUriSchemes : List Text }
            , reference =
                None
                  { allowLocal : Bool
                  , allowSelf : Bool
                  , externalUriPattern : Optional Text
                  , externalUriSchemes : List Text
                  , localPrefix : Text
                  }
            , when = None { field : Text, hasValue : List Text }
            }
          ]
        }
      , path = None { allowSelf : Bool, externalUriSchemes : List Text }
      , reference =
          None
            { allowLocal : Bool
            , allowSelf : Bool
            , externalUriPattern : Optional Text
            , externalUriSchemes : List Text
            , localPrefix : Text
            }
      , uniqueBy = None Text
      , when = None { field : Text, hasValue : List Text }
      }
    ]
  }
, guidance = None Text
, idField = Some "docId"
, name = "architecture-decision-records"
, okfVersion = "0.2"
, requireBundleVersion = Some "0.2"
, types =
  [ { description = Some
        "A durable record of one architecture decision and its rationale."
    , frontmatter =
      { optional =
          [] : List
                 { allowedValues : List Text
                 , cardinality : < Any | List | Scalar >
                 , description : Optional Text
                 , elementFields :
                     Optional
                       { optional :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , recommended :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , required :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       }
                 , field : Text
                 , format :
                     Optional
                       < Actor
                       | Boolean
                       | Date
                       | DocumentHandle : Text
                       | HumanActor
                       | Integer
                       | NonNegativeInteger
                       | Rfc3339Utc
                       | Uri
                       | UriWithScheme : Text
                       >
                 , objectFields :
                     Optional
                       { optional :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , recommended :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , required :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       }
                 , path :
                     Optional
                       { allowSelf : Bool, externalUriSchemes : List Text }
                 , reference :
                     Optional
                       { allowLocal : Bool
                       , allowSelf : Bool
                       , externalUriPattern : Optional Text
                       , externalUriSchemes : List Text
                       , localPrefix : Text
                       }
                 , uniqueBy : Optional Text
                 , when : Optional { field : Text, hasValue : List Text }
                 }
      , recommended =
          [] : List
                 { allowedValues : List Text
                 , cardinality : < Any | List | Scalar >
                 , description : Optional Text
                 , elementFields :
                     Optional
                       { optional :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , recommended :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , required :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       }
                 , field : Text
                 , format :
                     Optional
                       < Actor
                       | Boolean
                       | Date
                       | DocumentHandle : Text
                       | HumanActor
                       | Integer
                       | NonNegativeInteger
                       | Rfc3339Utc
                       | Uri
                       | UriWithScheme : Text
                       >
                 , objectFields :
                     Optional
                       { optional :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , recommended :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , required :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       }
                 , path :
                     Optional
                       { allowSelf : Bool, externalUriSchemes : List Text }
                 , reference :
                     Optional
                       { allowLocal : Bool
                       , allowSelf : Bool
                       , externalUriPattern : Optional Text
                       , externalUriSchemes : List Text
                       , localPrefix : Text
                       }
                 , uniqueBy : Optional Text
                 , when : Optional { field : Text, hasValue : List Text }
                 }
      , required =
          [] : List
                 { allowedValues : List Text
                 , cardinality : < Any | List | Scalar >
                 , description : Optional Text
                 , elementFields :
                     Optional
                       { optional :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , recommended :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , required :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       }
                 , field : Text
                 , format :
                     Optional
                       < Actor
                       | Boolean
                       | Date
                       | DocumentHandle : Text
                       | HumanActor
                       | Integer
                       | NonNegativeInteger
                       | Rfc3339Utc
                       | Uri
                       | UriWithScheme : Text
                       >
                 , objectFields :
                     Optional
                       { optional :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , recommended :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       , required :
                           List
                             { allowedValues : List Text
                             , cardinality : < Any | List | Scalar >
                             , description : Optional Text
                             , field : Text
                             , format :
                                 Optional
                                   < Actor
                                   | Boolean
                                   | Date
                                   | DocumentHandle : Text
                                   | HumanActor
                                   | Integer
                                   | NonNegativeInteger
                                   | Rfc3339Utc
                                   | Uri
                                   | UriWithScheme : Text
                                   >
                             , path :
                                 Optional
                                   { allowSelf : Bool
                                   , externalUriSchemes : List Text
                                   }
                             , reference :
                                 Optional
                                   { allowLocal : Bool
                                   , allowSelf : Bool
                                   , externalUriPattern : Optional Text
                                   , externalUriSchemes : List Text
                                   , localPrefix : Text
                                   }
                             , when :
                                 Optional { field : Text, hasValue : List Text }
                             }
                       }
                 , path :
                     Optional
                       { allowSelf : Bool, externalUriSchemes : List Text }
                 , reference :
                     Optional
                       { allowLocal : Bool
                       , allowSelf : Bool
                       , externalUriPattern : Optional Text
                       , externalUriSchemes : List Text
                       , localPrefix : Text
                       }
                 , uniqueBy : Optional Text
                 , when : Optional { field : Text, hasValue : List Text }
                 }
      }
    , guidance = None Text
    , idPrefix = Some "ADR"
    , pathPattern = Some "*"
    , requireSchemaSection = False
    , resourceScheme = None Text
    , schemaColumns = [] : List Text
    , type = "Architecture Decision Record"
    }
  ]
}