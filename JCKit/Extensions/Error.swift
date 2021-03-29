extension Error {
    var code: Int { return (self as NSError).code }
}
