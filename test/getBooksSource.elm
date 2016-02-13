getBooks : Bool -> Maybe (String) -> List (Maybe Bool) -> Task.Task Http.Error (List (Book))
getBooks published sort filters =
  let request =
        { verb = "GET"
        , headers = [("Content-Type", "application/json")]
        , url = "/" ++ "books"
             ++ "?" ++ if published then "published=" else ""
             ++ "&" ++ "sort=" ++ (sort |> toString |> Http.uriEncode)
             ++ "&" ++ String.join "&" (List.map (\val -> "filters[]=" ++ (val |> toString |> Http.uriEncode)) filters)
        , body = Http.empty
        }
  in  Http.fromJson
        (Json.Decode.list decodeBook)
        (Http.send Http.defaultSettings request)