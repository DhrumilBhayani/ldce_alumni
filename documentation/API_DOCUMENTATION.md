# LDCE Connect — API Documentation

> **Base URL:** `https://ldcealumniapi.devitsandbox.com/api/`
>
> **Production URL:** `http://api.ldcealumni.net/api/` *(currently inactive in code)*

---

## 1. Overview

The LDCE Connect mobile app communicates with a RESTful backend API built on **ASP.NET**. All responses follow a standardized JSON wrapper format.

### Standard Response Format

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [ ... ]   // Array for lists, Object for single items
}
```

### Authentication

Authenticated endpoints require an **OAuth2 Bearer Token** in the `Authorization` header:

```
Authorization: Bearer <access_token>
```

### Common Query Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `pageSize` | `int` | 5 or 25 | Number of items per page |
| `pageNumber` | `int` | 1 | Page number (1-indexed) |

---

## 2. Authentication API

### 2.1 Login

Authenticates a user and returns an OAuth2 access token.

| Property | Value |
|---|---|
| **Endpoint** | `POST /Login` |
| **Auth Required** | No |

**Request Headers:**
```
Content-Type: application/x-www-form-urlencoded
Accept: */*
```

**Request Body (form-encoded):**

| Field | Type | Required | Description |
|---|---|---|---|
| `grant_type` | `string` | Yes | Must be `"password"` |
| `username` | `string` | Yes | User email address |
| `password` | `string` | Yes | User password |
| `remember` | `string` | Yes | Must be `"true"` |

**Response:**

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "token_type": "bearer",
  "expires_in": 86400
}
```

| Field | Type | Description |
|---|---|---|
| `access_token` | `string` | JWT access token |
| `token_type` | `string` | Token type (`"bearer"`) |
| `expires_in` | `int` | Expiry time in seconds |

---

### 2.2 Get Encrypted Alumni ID

Retrieves the encrypted alumni ID for the authenticated user. Used for profile queries.

| Property | Value |
|---|---|
| **Endpoint** | `GET /Alumni/GetId` |
| **Auth Required** | Yes (Bearer Token) |

**Request Headers:**
```
Content-Type: application/x-www-form-urlencoded
Accept: */*
Authorization: Bearer <access_token>
```

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": "pMcGf5SbRO0="
}
```

---

## 3. Home / Slider API

### 3.1 Get Home Slider Images

Retrieves the carousel/slider images for the home screen.

| Property | Value |
|---|---|
| **Endpoint** | `GET /Slider` |
| **Auth Required** | No |

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [
    "https://ldcealumni.net/Content/Slider/image1.jpg",
    "https://ldcealumni.net/Content/Slider/image2.jpg"
  ]
}
```

---

## 4. News API

### 4.1 Get News (Paginated)

Retrieves a paginated list of news articles.

| Property | Value |
|---|---|
| **Endpoint** | `GET /News/GetNewsPaging` |
| **Auth Required** | No |

**Query Parameters:**

| Param | Type | Default | Description |
|---|---|---|---|
| `pageSize` | `int` | 5 | Items per page |
| `pageNumber` | `int` | 1 | Page number |

**Example:** `GET /News/GetNewsPaging?pageSize=5&pageNumber=1`

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [
    {
      "CoverPhotoPath": "https://ldcealumni.net/Content/News/Cover/photo.jpg",
      "CreatedOn": "2023-01-15T10:30:00",
      "Title": "Alumni Meet 2023",
      "Description": "Short description of the news...",
      "HtmlContent": "<p>Full HTML content...</p>",
      "Attachement": [
        { "Path": "https://ldcealumni.net/Content/News/att1.pdf" }
      ]
    }
  ]
}
```

**Response Fields:**

| Field | Type | Description |
|---|---|---|
| `CoverPhotoPath` | `string` | URL of cover image (may be `"null"`) |
| `CreatedOn` | `string` | ISO 8601 creation date |
| `Title` | `string` | News title |
| `Description` | `string` | Short description / summary |
| `HtmlContent` | `string` | Full HTML body content |
| `Attachement` | `array` | List of attachment objects with `Path` |

---

### 4.2 Get Single News

Retrieves a single news article by ID.

| Property | Value |
|---|---|
| **Endpoint** | `GET /News/{id}` |
| **Auth Required** | No |

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": {
    "Id": 42,
    "CoverPhotoPath": "...",
    "CreatedOn": "...",
    "Title": "...",
    "Description": "...",
    "HtmlContent": "...",
    "Attachement": [...]
  }
}
```

---

## 5. Events API

### 5.1 Get Events (Paginated)

Retrieves a paginated list of all events. The app client-side separates events into **upcoming** and **past** based on `StartDate`.

| Property | Value |
|---|---|
| **Endpoint** | `GET /Events/GetEventPaging` |
| **Auth Required** | No |

**Query Parameters:**

| Param | Type | Default | Description |
|---|---|---|---|
| `pageSize` | `int` | 5 | Items per page |
| `pageNumber` | `int` | 1 | Page number |

**Example:** `GET /Events/GetEventPaging?pageSize=5&pageNumber=1`

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [
    {
      "Id": 31,
      "EncryptedEventId": "pMcGf5SbRO0=",
      "Title": "LDCE@75 Curtain Raiser Event",
      "Description": "Short description...",
      "HtmlContent": "Full HTML content...",
      "Venue": "Central Plaza (Fondly known as Student Square)",
      "ContactPerson": "Prof Chaitanya Sanghavi",
      "StartDate": "2022-04-01T17:00:00",
      "EndDate": "2022-04-01T17:01:00",
      "CreatedOn": "2022-03-31T07:35:48.07",
      "HasCoverPhoto": true,
      "CoverPhotoPath": "ldcealumni.net/Content/Event/Cover/photo.jpg",
      "Attachement": []
    }
  ]
}
```

**Response Fields:**

| Field | Type | Description |
|---|---|---|
| `Id` | `int` | Event ID |
| `EncryptedEventId` | `string` | Encrypted event identifier |
| `Title` | `string` | Event title |
| `Description` | `string` | Short description |
| `HtmlContent` | `string` | Full HTML body |
| `Venue` | `string` | Event venue |
| `ContactPerson` | `string` | Contact person name |
| `StartDate` | `string` | ISO 8601 start date |
| `EndDate` | `string` | ISO 8601 end date |
| `CreatedOn` | `string` | ISO 8601 creation date |
| `HasCoverPhoto` | `bool` | Whether cover photo exists |
| `CoverPhotoPath` | `string` | URL of cover photo |
| `Attachement` | `array` | List of attachment objects |

---

### 5.2 Get Single Event

| Property | Value |
|---|---|
| **Endpoint** | `GET /Events/{id}` |
| **Auth Required** | No |

**Response:** Same structure as above, with `Result` as a single object.

---

## 6. Alumni Directory API

### 6.1 Get Alumni (Paginated)

| Property | Value |
|---|---|
| **Endpoint** | `GET /Alumni/GetAlumniDirectoryPaging` |
| **Auth Required** | No |

**Query Parameters:**

| Param | Type | Default | Description |
|---|---|---|---|
| `pageSize` | `int` | 25 | Items per page |
| `pageNumber` | `int` | 1 | Page number |

**Example:** `GET /Alumni/GetAlumniDirectoryPaging?pageSize=25&pageNumber=1`

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [
    {
      "FullName": "Dhrumil Bhayani",
      "PassoutYear": "2020",
      "Program": "B.E.",
      "Branch": "Computer Engineering",
      "Membership": "Life Member",
      "CompanyName": "TechCorp"
    }
  ]
}
```

---

### 6.2 Search Alumni

| Property | Value |
|---|---|
| **Endpoint** | `GET /Alumni/SearchAlumni` |
| **Auth Required** | No |

**Query Parameters:**

| Param | Type | Required | Description |
|---|---|---|---|
| `name` | `string` | No | Name filter |
| `passoutYear` | `string` | No | Graduation year (or `"All"`) |
| `degree` | `string` | No | Degree program filter |
| `branch` | `string` | No | Branch filter (or `"All"`) |
| `membershipType` | `string` | No | Membership type filter |
| `pageSize` | `int` | No | Items per page (default 25) |
| `pageNumber` | `int` | No | Page number (default 1) |

**Example:** `GET /Alumni/SearchAlumni?name=akash&passoutYear=&degree=&branch=&membershipType=&pageSize=25&pageNumber=1`

**Response:** Same structure as Get Alumni.

---

## 7. Media Gallery API

### 7.1 Get Media Galleries (Paginated)

| Property | Value |
|---|---|
| **Endpoint** | `GET /MediaGalleries/GetMediaGalleryPaging` |
| **Auth Required** | No |

**Query Parameters:**

| Param | Type | Default | Description |
|---|---|---|---|
| `pageSize` | `int` | 5 | Items per page |
| `pageNumber` | `int` | 1 | Page number |

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [
    {
      "CoverPhotoPath": "https://ldcealumni.net/Content/Media/Cover/photo.jpg",
      "CreatedOn": "2023-01-10T08:00:00",
      "Title": "Annual Day 2023",
      "Description": "Short description...",
      "HtmlContent": "Full HTML...",
      "Attachement": [
        { "Path": "https://ldcealumni.net/Content/Media/img1.jpg" },
        { "Path": "https://ldcealumni.net/Content/Media/img2.jpg" }
      ]
    }
  ]
}
```

---

## 8. Noteworthy Achievements API

### 8.1 Get Achievements (Paginated)

| Property | Value |
|---|---|
| **Endpoint** | `GET /Achievements/GetAchievementPaging` |
| **Auth Required** | No |

**Query Parameters:**

| Param | Type | Default | Description |
|---|---|---|---|
| `pageSize` | `int` | 5 | Items per page |
| `pageNumber` | `int` | 1 | Page number |

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [
    {
      "CoverPhotoPath": "https://ldcealumni.net/Content/Achievement/photo.jpg",
      "Title": "Best Alumni Award",
      "Description": "Short description...",
      "HtmlContent": "Full HTML...",
      "AlumniName": "Dr. Rakesh Patel",
      "AlumniBranch": "Electrical Engineering",
      "AlumniPassoutYear": "1995"
    }
  ]
}
```

---

## 9. Digital Downloads API

### 9.1 Get All Digital Downloads

| Property | Value |
|---|---|
| **Endpoint** | `GET /DigitalDownload` |
| **Auth Required** | No |

### 9.2 Get by Category (Paginated)

Each category appends its identifier as a query flag:

| Category | Endpoint |
|---|---|
| Mobile Skins | `GET /DigitalDownload?Mobileskin&pageSize=5&pageNumber=1` |
| Desktop Wallpapers | `GET /DigitalDownload?DesktopWallpaper&pageSize=5&pageNumber=1` |
| Calendars | `GET /DigitalDownload?Calendar&pageSize=5&pageNumber=1` |
| Campaign Downloads | `GET /DigitalDownload?CampaignDownload&pageSize=5&pageNumber=1` |
| Other Materials | `GET /DigitalDownload?OtherMaterial&pageSize=5&pageNumber=1` |

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [
    {
      "Title": "LDCE@75 Mobile Skin",
      "Description": "Diamond Jubilee skin...",
      "CategoryType": "Mobileskin",
      "FileName": "https://ldcealumni.net/Content/Download/skin.png",
      "PDFFileName": "https://ldcealumni.net/Content/Download/skin.pdf"
    }
  ]
}
```

### 9.3 Get Single Digital Download

| Property | Value |
|---|---|
| **Endpoint** | `GET /DigitalDownload/{id}` |
| **Auth Required** | No |

---

## 10. Profile API

### 10.1 Get Alumni Profile

| Property | Value |
|---|---|
| **Endpoint** | `GET /alumni?EncryptedId={encId}` |
| **Auth Required** | No (uses encrypted ID) |

**Response:**

```json
{
  "Status": true,
  "Message": "Success",
  "Result": {
    "EncryptedId": "pMcGf5SbRO0=",
    "FirstName": "Dhrumil",
    "MiddleName": "",
    "LastName": "Bhayani",
    "FullName": "Dhrumil Bhayani",
    "Gender": true,
    "DOB": "1998-05-15",
    "CountryId": 1,
    "StateId": 12,
    "CityId": 42,
    "ProfilePicPath": "https://ldcealumni.net/Content/Profile/photo.jpg",
    "PrimaryAddress": "123 Main St",
    "SecondaryAddress": "",
    "EmailAddress": "dhrumil@example.com",
    "PinCode": "380015",
    "MobileNo": "9876543210",
    "TelephoneNo": "",
    "CompanyName": "TechCorp",
    "CompanyAddress": "456 Tech Park",
    "Designation": "Software Engineer",
    "PassoutYear": "2020",
    "StreamId": 1,
    "DegreeId": 1,
    "MembershipTypeId": 2,
    "Membership": "Life Member",
    "IsMembershipVerified": true
  }
}
```

**Profile Fields:**

| Field | Type | Description |
|---|---|---|
| `EncryptedId` | `string` | Encrypted alumni identifier |
| `FirstName` | `string` | First name |
| `MiddleName` | `string` | Middle name |
| `LastName` | `string` | Last name |
| `FullName` | `string` | Combined full name |
| `Gender` | `bool` | Gender flag |
| `DOB` | `string` | Date of birth |
| `CountryId` | `int` | Country reference ID |
| `StateId` | `int` | State reference ID |
| `CityId` | `int` | City reference ID |
| `ProfilePicPath` | `string` | Profile picture URL |
| `PrimaryAddress` | `string` | Primary address |
| `SecondaryAddress` | `string` | Secondary address |
| `EmailAddress` | `string` | Email address |
| `PinCode` | `string` | Postal/ZIP code |
| `MobileNo` | `string` | Mobile number |
| `TelephoneNo` | `string` | Telephone number |
| `CompanyName` | `string` | Current employer |
| `CompanyAddress` | `string` | Company address |
| `Designation` | `string` | Job title |
| `PassoutYear` | `string` | Graduation year |
| `StreamId` | `int` | Stream/branch reference ID |
| `DegreeId` | `int` | Degree program reference ID |
| `MembershipTypeId` | `int` | Membership type reference ID |
| `Membership` | `string` | Membership type name |
| `IsMembershipVerified` | `bool` | Verification status |

---

## 11. API Endpoint Summary Table

| # | Method | Endpoint | Auth | Description |
|---|---|---|---|---|
| 1 | `POST` | `/Login` | No | User authentication |
| 2 | `GET` | `/Alumni/GetId` | Yes | Get encrypted alumni ID |
| 3 | `GET` | `/Slider` | No | Home carousel images |
| 4 | `GET` | `/News/GetNewsPaging` | No | Paginated news list |
| 5 | `GET` | `/News/{id}` | No | Single news article |
| 6 | `GET` | `/Events/GetEventPaging` | No | Paginated events list |
| 7 | `GET` | `/Events/{id}` | No | Single event details |
| 8 | `GET` | `/Alumni/GetAlumniDirectoryPaging` | No | Paginated alumni directory |
| 9 | `GET` | `/Alumni/SearchAlumni` | No | Search alumni with filters |
| 10 | `GET` | `/alumni?EncryptedId={encId}` | No | Alumni profile details |
| 11 | `GET` | `/MediaGalleries/GetMediaGalleryPaging` | No | Paginated media galleries |
| 12 | `GET` | `/Achievements/GetAchievementPaging` | No | Paginated achievements |
| 13 | `GET` | `/DigitalDownload` | No | All digital downloads |
| 14 | `GET` | `/DigitalDownload?Mobileskin` | No | Mobile skins (paginated) |
| 15 | `GET` | `/DigitalDownload?DesktopWallpaper` | No | Desktop wallpapers (paginated) |
| 16 | `GET` | `/DigitalDownload?Calendar` | No | Calendars (paginated) |
| 17 | `GET` | `/DigitalDownload?CampaignDownload` | No | Campaign downloads (paginated) |
| 18 | `GET` | `/DigitalDownload?OtherMaterial` | No | Other materials (paginated) |
| 19 | `GET` | `/DigitalDownload/{id}` | No | Single digital download |

---

## 12. Error Handling

The app handles the following HTTP/network error scenarios:

| Error Type | Dart Exception | App Behavior |
|---|---|---|
| Request Timeout | `TimeoutException` | Logged, returns empty string |
| No Network | `SocketException` | Navigate to No Internet screen |
| SSL Error | `HandshakeException` | Navigate to No Internet screen |
| General Error | `Error` | Logged, `exceptionCreated` flag set |
| Non-200 Status | N/A | Returns empty string, UI shows empty state |

### Timeout Configuration
- **Default timeout:** 40 seconds (configurable via `globals.timeout`)
- **Internet check:** HTTP GET to `https://google.com` with 40s timeout
