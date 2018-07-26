
# "inputGoList" contains the list of GO categories with (optionally) an associated value. The list should be a single long string, formatted to match the examples given on revigo.irb.hr. This parameter is obligatory; all others are optional. 
# "outputListSize" can be one of: [large, medium, small, tiny] 
# "isPValue" can be one of: [yes, no] 
# "whatIsBetter" can be one of: [higher, lower, absolute, abs_log] 
# "goSizes" can be: "UniProt", or any of the supported organism-specific UniProt subsets; please use the full name of organism as given in the drop-down list on the entry page of REVIGO, such as "Homo sapiens". 
# "measure" can be on of the following: [RESNIK, LIN, SIMREL, JIANG] 


# revigo <- list(
#   inputGoList = "login",
#   outputListSize = "password",
#   isPValue = "Login!",
#   whatIsBetter = "Login!",
#   goSizes = "Login!",
#   measure = "Login!",
# )
# 
# url <- "http://revigo.irb.hr"
# revigo_url <- function(path = "") {
#   url <- modify_url("http://revigo.irb.hr", path = path)
#   return(url)
# }
# 
# revigo <- list(
#   goList = "GO:0009268 1e-14
#   GO:0010447 1e-14
#   GO:0000027 1e-297
#   GO:0042255 1e-297
#   GO:0042257 1e-297
#   GO:0042273 1e-297
#   GO:0030880 1e-17
#   GO:0009775 1e-13
#   GO:0009853 1e-11
#   GO:0030255 1e-18
#   GO:0015797 1e-11
#   GO:0045158 1e-27
#   GO:0000786 1e-31
#   GO:0006334 1e-31
#   GO:0034728 1e-31
#   GO:0009539 1e-12
#   GO:0000785 1e-30
#   GO:0009635 1e-31
#   GO:0008097 1e-155
#   GO:0051262 1e-84
#   GO:0009772 1e-57
#   GO:0051259 1e-83
#   GO:0006183 1e-144
#   GO:0006228 1e-144
#   GO:0006241 1e-144
#   GO:0009208 1e-144
#   GO:0009209 1e-144
#   GO:0046036 1e-144
#   GO:0046051 1e-144
#   GO:0045156 1e-73
#   GO:0042026 1e-204
#   GO:0030096 1e-7
#   GO:0005960 1e-144
#   GO:0004550 1e-142
#   GO:0050044 1e-17
#   GO:0009503 1e-68
#   GO:0009534 1e-68
#   GO:0009535 1e-68
#   GO:0055035 1e-68
#   GO:0009767 1e-77
#   GO:0016159 1e-15
#   GO:0019646 1e-14
#   GO:0009522 1e-49
#   GO:0030077 1e-50
#   GO:0031647 1e-7
#   GO:0050821 1e-7
#   GO:0006450 1e-95
#   GO:0031361 1e-6
#   GO:0009538 1e-17
#   GO:0009595 1e-8
#   GO:0009597 1e-8
#   GO:0009615 1e-8
#   GO:0030260 1e-8
#   GO:0044409 1e-8
#   GO:0046718 1e-8
#   GO:0051806 1e-8
#   GO:0051828 1e-8
#   GO:0052126 1e-8
#   GO:0052192 1e-8
#   GO:0008553 1e-125
#   GO:0043801 1e-7
#   GO:0042651 1e-184
#   GO:0009496 1e-8
#   GO:0042716 1e-121
#   GO:0030076 1e-122
#   GO:0033177 1e-265
#   GO:0045263 1e-265
#   GO:0044433 1e-113
#   GO:0010109 1e-9
#   GO:0042548 1e-9
#   GO:0042549 1e-9
#   GO:0043467 1e-9
#   GO:0030075 1e-76
#   GO:0044434 1e-80
#   GO:0030388 1e-25
#   GO:0009579 1e-193
#   GO:0044436 1e-187
#   GO:0009842 1e-66
#   GO:0009843 1e-66
#   GO:0030089 1e-66
#   GO:0002526 1e-6
#   GO:0005201 1e-4
#   GO:0006954 1e-6
#   GO:0031976 1e-67
#   GO:0031984 1e-67
#   GO:0045259 1e-300
#   GO:0004455 1e-70
#   GO:0034357 1e-197
#   GO:0003878 1e-68
#   GO:0016168 1e-22
#   GO:0009654 1e-14
#   GO:0016721 1e-117
#   GO:0050278 1e-4
#   GO:0004784 1e-114
#   GO:0004493 1e-15
#   GO:0033178 1e-290
#   GO:0045261 1e-290
#   GO:0042777 1e-270
#   GO:0009314 1e-5
#   GO:0009416 1e-5
#   GO:0009581 1e-5
#   GO:0009582 1e-5
#   GO:0009583 1e-5
#   GO:0046933 1e-300
#   GO:0008124 1e-34
#   GO:0002250 1e-5
#   GO:0002252 1e-5
#   GO:0002437 1e-5
#   GO:0002438 1e-5
#   GO:0002443 1e-5
#   GO:0002449 1e-5
#   GO:0002460 1e-5
#   GO:0002524 1e-5
#   GO:0016064 1e-5
#   GO:0016068 1e-5
#   GO:0019724 1e-5
#   GO:0009145 1e-300
#   GO:0009201 1e-300
#   GO:0009206 1e-300
#   GO:0019253 1e-17
#   GO:0015985 1e-300
#   GO:0015986 1e-300
#   GO:0044435 1e-83
#   GO:0018551 1e-10
#   GO:0046961 1e-300
#   GO:0016037 1e-4
#   GO:0006662 1e-142
#   GO:0019684 1e-86
#   GO:0031410 1e-95
#   GO:0000070 1e-23
#   GO:0000819 1e-23
#   GO:0007076 1e-23
#   GO:0031982 1e-94
#   GO:0022618 1e-212
#   GO:0007067 1e-23
#   GO:0046034 1e-300
#   GO:0006754 1e-300
#   GO:0004774 1e-98
#   GO:0004775 1e-98
#   GO:0006414 1e-300
#   GO:0051920 1e-52
#   GO:0009521 1e-86
#   GO:0000087 1e-22
#   GO:0000278 1e-22
#   GO:0000279 1e-22
#   GO:0022402 1e-22
#   GO:0022403 1e-22
#   GO:0009144 1e-300
#   GO:0009199 1e-300
#   GO:0009205 1e-300
#   GO:0030700 1e-4
#   GO:0030115 1e-3
#   GO:0009507 1e-66
#   GO:0009611 1e-5
#   GO:0004634 1e-58
#   GO:0000015 1e-57
#   GO:0008379 1e-26
#   GO:0019829 1e-300
#   GO:0009142 1e-300
#   GO:0003735 1e-300
#   GO:0009420 1e-77
#   GO:0003746 1e-300
#   GO:0045152 1e-44
#   GO:0009536 1e-85
#   GO:0004512 1e-10
#   GO:0006021 1e-10
#   GO:0006102 1e-10
#   GO:0004068 1e-26
#   GO:0006523 1e-26
#   GO:0009079 1e-26
#   GO:0009349 1e-45
#   GO:0016469 1e-300
#   GO:0005198 1e-300
#   GO:0004427 1e-62
#   GO:0005840 1e-300
#   GO:0015035 1e-280
#   GO:0033990 1e-4
#   GO:0046039 1e-71
#   GO:0009532 1e-19
#   GO:0009570 1e-19
#   GO:0009573 1e-19
#   GO:0016984 1e-19
#   GO:0048492 1e-19
#   GO:0009141 1e-300
#   GO:0006879 1e-84
#   GO:0055072 1e-84
#   GO:0019031 1e-4
#   GO:0009523 1e-41
#   GO:0030261 1e-20
#   GO:0030529 1e-300
#   GO:0004322 1e-4
#   GO:0016724 1e-4
#   GO:0019954 1e-14
#   GO:0032505 1e-14
#   GO:0043093 1e-14
#   GO:0006808 1e-88
#   GO:0019740 1e-88
#   GO:0051171 1e-87
#   GO:0004365 1e-64
#   GO:0045252 1e-23
#   GO:0019898 1e-5
#   GO:0034220 1e-300
#   GO:0008943 1e-64
#   GO:0010608 1e-124
#   GO:0006818 1e-300
#   GO:0015992 1e-300
#   GO:0006417 1e-119
#   GO:0046538 1e-16
#   GO:0045300 1e-5
#   GO:0031405 1e-99
#   GO:0031406 1e-99
#   GO:0015036 1e-237
#   GO:0055085 1e-300
#   GO:0031326 1e-113",
#   goSizes = 0,
#   cutoff = 0.7,
#   startRevigo = "Please wait...",
#   isPValue = "yes",
#   measure = "SIMREL",
#   whatIsBetter = "higher"
# )

# GO:0009268 1e-14
# GO:0010447 1e-14
# GO:0000027 1e-297
# GO:0042255 1e-297
# GO:0042257 1e-297
# GO:0042273 1e-297
# GO:0030880 1e-17
# GO:0009775 1e-13
# GO:0009853 1e-11
# GO:0030255 1e-18
# GO:0015797 1e-11
# GO:0045158 1e-27
# GO:0000786 1e-31
# GO:0006334 1e-31
# GO:0034728 1e-31
# GO:0009539 1e-12
# GO:0000785 1e-30
# GO:0009635 1e-31
# GO:0008097 1e-155
# GO:0051262 1e-84
# GO:0009772 1e-57
# GO:0051259 1e-83
# GO:0006183 1e-144
# GO:0006228 1e-144
# GO:0006241 1e-144
# GO:0009208 1e-144
# GO:0009209 1e-144
# GO:0046036 1e-144
# GO:0046051 1e-144
# GO:0045156 1e-73
# GO:0042026 1e-204
# GO:0030096 1e-7
# GO:0005960 1e-144
# GO:0004550 1e-142
# GO:0050044 1e-17
# GO:0009503 1e-68
# GO:0009534 1e-68
# GO:0009535 1e-68
# GO:0055035 1e-68
# GO:0009767 1e-77
# GO:0016159 1e-15
# GO:0019646 1e-14
# GO:0009522 1e-49
# GO:0030077 1e-50
# GO:0031647 1e-7
# GO:0050821 1e-7
# GO:0006450 1e-95
# GO:0031361 1e-6
# GO:0009538 1e-17
# GO:0009595 1e-8
# GO:0009597 1e-8
# GO:0009615 1e-8
# GO:0030260 1e-8
# GO:0044409 1e-8
# GO:0046718 1e-8
# GO:0051806 1e-8
# GO:0051828 1e-8
# GO:0052126 1e-8
# GO:0052192 1e-8
# GO:0008553 1e-125
# GO:0043801 1e-7
# GO:0042651 1e-184
# GO:0009496 1e-8
# GO:0042716 1e-121
# GO:0030076 1e-122
# GO:0033177 1e-265
# GO:0045263 1e-265
# GO:0044433 1e-113
# GO:0010109 1e-9
# GO:0042548 1e-9
# GO:0042549 1e-9
# GO:0043467 1e-9
# GO:0030075 1e-76
# GO:0044434 1e-80
# GO:0030388 1e-25
# GO:0009579 1e-193
# GO:0044436 1e-187
# GO:0009842 1e-66
# GO:0009843 1e-66
# GO:0030089 1e-66
# GO:0002526 1e-6
# GO:0005201 1e-4
# GO:0006954 1e-6
# GO:0031976 1e-67
# GO:0031984 1e-67
# GO:0045259 1e-300
# GO:0004455 1e-70
# GO:0034357 1e-197
# GO:0003878 1e-68
# GO:0016168 1e-22
# GO:0009654 1e-14
# GO:0016721 1e-117
# GO:0050278 1e-4
# GO:0004784 1e-114
# GO:0004493 1e-15
# GO:0033178 1e-290
# GO:0045261 1e-290
# GO:0042777 1e-270
# GO:0009314 1e-5
# GO:0009416 1e-5
# GO:0009581 1e-5
# GO:0009582 1e-5
# GO:0009583 1e-5
# GO:0046933 1e-300
# GO:0008124 1e-34
# GO:0002250 1e-5
# GO:0002252 1e-5
# GO:0002437 1e-5
# GO:0002438 1e-5
# GO:0002443 1e-5
# GO:0002449 1e-5
# GO:0002460 1e-5
# GO:0002524 1e-5
# GO:0016064 1e-5
# GO:0016068 1e-5
# GO:0019724 1e-5
# GO:0009145 1e-300
# GO:0009201 1e-300
# GO:0009206 1e-300
# GO:0019253 1e-17
# GO:0015985 1e-300
# GO:0015986 1e-300
# GO:0044435 1e-83
# GO:0018551 1e-10
# GO:0046961 1e-300
# GO:0016037 1e-4
# GO:0006662 1e-142
# GO:0019684 1e-86
# GO:0031410 1e-95
# GO:0000070 1e-23
# GO:0000819 1e-23
# GO:0007076 1e-23
# GO:0031982 1e-94
# GO:0022618 1e-212
# GO:0007067 1e-23
# GO:0046034 1e-300
# GO:0006754 1e-300
# GO:0004774 1e-98
# GO:0004775 1e-98
# GO:0006414 1e-300
# GO:0051920 1e-52
# GO:0009521 1e-86
# GO:0000087 1e-22
# GO:0000278 1e-22
# GO:0000279 1e-22
# GO:0022402 1e-22
# GO:0022403 1e-22
# GO:0009144 1e-300
# GO:0009199 1e-300
# GO:0009205 1e-300
# GO:0030700 1e-4
# GO:0030115 1e-3
# GO:0009507 1e-66
# GO:0009611 1e-5
# GO:0004634 1e-58
# GO:0000015 1e-57
# GO:0008379 1e-26
# GO:0019829 1e-300
# GO:0009142 1e-300
# GO:0003735 1e-300
# GO:0009420 1e-77
# GO:0003746 1e-300
# GO:0045152 1e-44
# GO:0009536 1e-85
# GO:0004512 1e-10
# GO:0006021 1e-10
# GO:0006102 1e-10
# GO:0004068 1e-26
# GO:0006523 1e-26
# GO:0009079 1e-26
# GO:0009349 1e-45
# GO:0016469 1e-300
# GO:0005198 1e-300
# GO:0004427 1e-62
# GO:0005840 1e-300
# GO:0015035 1e-280
# GO:0033990 1e-4
# GO:0046039 1e-71
# GO:0009532 1e-19
# GO:0009570 1e-19
# GO:0009573 1e-19
# GO:0016984 1e-19
# GO:0048492 1e-19
# GO:0009141 1e-300
# GO:0006879 1e-84
# GO:0055072 1e-84
# GO:0019031 1e-4
# GO:0009523 1e-41
# GO:0030261 1e-20
# GO:0030529 1e-300
# GO:0004322 1e-4
# GO:0016724 1e-4
# GO:0019954 1e-14
# GO:0032505 1e-14
# GO:0043093 1e-14
# GO:0006808 1e-88
# GO:0019740 1e-88
# GO:0051171 1e-87
# GO:0004365 1e-64
# GO:0045252 1e-23
# GO:0019898 1e-5
# GO:0034220 1e-300
# GO:0008943 1e-64
# GO:0010608 1e-124
# GO:0006818 1e-300
# GO:0015992 1e-300
# GO:0006417 1e-119
# GO:0046538 1e-16
# GO:0045300 1e-5
# GO:0031405 1e-99
# GO:0031406 1e-99
# GO:0015036 1e-237
# GO:0055085 1e-300
# GO:0031326 1e-113

# urlR1 <- "toR.jsp?table=1"
# urlE1 <- "export.jsp?table=1"
# 
# 
# res <- POST(revigo_url("revigo.jsp"), body = revigo, encode = "form", verbose())
# 
# 
# 
# res2 <- POST("http://revigo.irb.hr/toR.jsp?table=1", body = revigo, encode = "form", verbose())
# GET(revigo_url(urlE1), verbose())
# 
# save_file <- function(r){
#   bin <- content(r, "raw")
#   writeBin(bin, "myfile.txt")
# }
# 
# 
# ua <- user_agent("Mozilla/5.0")
# headers <- add_headers(Referer = revigo_url())
# cookies <- set_cookies(JSESSIONID = "14e25c478673cbab6d0e6081e26e",
#                        "__atuvc" = "6|30",
#                        "__utma" = "51712554.1609266952.1532507663.1532507663.1532519964.2",
#                        "__utmc" = "51712554",
#                        "__utmz" = "51712554.1532507663.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)",
#                        "__atuvs" = "5b586611e578a182003",
#                        "__utmb" = "51712554.1.10.1532519964")
# 
# 
# GET(url, write_disk("iris.xlsx", overwrite=TRUE))
# 
# 
# 
# library(RCurl)
# library(XML)
# curl = getCurlHandle()
# curlSetOpt(cookiefile="cookies.txt"
#            , curl=curl, followLocation = TRUE)
# pdfData <- getBinaryURL(urlR1, curl = curl, .opts = list(cookie = paste0("JSESSIONID=",sessionId)))
# writeBin(pdfData, "test2.txt")