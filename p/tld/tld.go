package tld

import (
	"fmt"
	"strings"

	"github.com/AndrewDonelson/gno.lair/p/util"
	"golang.org/x/net/publicsuffix"
)

// AllowedOrigins hold all valid remote origins
var AllowedOrigins []string

// getFQDN is a helper function to return the valid FQDN for the given string (request?)
func getFQDN(srcurl string) (str string, err error) {

	//golog.Log.Debugf("GetFQDN: parsing [%s]",srcurl)
	// shortest domain ex. a.io (4), and must have at least 1 DOT
	if len(srcurl) < 4 || strings.Count(srcurl, ".") < 1 {
		return "", fmt.Errorf("not a valid URL")
	}

	eTLD, icann := publicsuffix.PublicSuffix(srcurl)
	//golog.Log.Debugf("eTLD from Public Suffix [%s] ICANN [%v]",eTLD,icann)
	if !icann {
		// lets try and catch shit like eu.com
		// which is both a TLD and a domain. So if only 2 elements
		// we will assume the src url is a domain
		// otherwise it treated as TLD
		//golog.Log.Debugf("Check for X.com style eTLD's")
		s := strings.Split(srcurl, ".")
		if strings.HasSuffix(eTLD, ".com") && len(s) == 2 {
			//golog.Log.Debugf("eTLD [%s] re-mapping to [%s.%s]", eTLD, s[0], s[1])
			eTLD = s[1]
			srcurl = s[0]
		}
	}

	srcurl = strings.Replace(srcurl, "."+eTLD, "", -1)

	if srcurl == "" {
		return "", fmt.Errorf("detected eTLD [%s] but no HOST [%s] for URL", eTLD, srcurl)
	}

	if strings.HasPrefix(srcurl, "http://") {
		srcurl = strings.Replace(srcurl, "http://", "", -1)
	}

	if strings.HasPrefix(srcurl, "https://") {
		srcurl = strings.Replace(srcurl, "https://", "", -1)
	}

	dots := strings.Count(srcurl, ".")
	if dots == 0 {
		return fmt.Sprintf("%s.%s", srcurl, eTLD), nil
	}

	sub := strings.Split(srcurl, ".")
	return fmt.Sprintf("%s.%s", sub[len(sub)-1], eTLD), nil
}

// ValidateOrigin called from within StartServer to validate the the requesting domain
func ValidateOrigin(origin string) bool {
	//golog.Log.Debugf("CORS: Validating origin [%s]", origin)
	u, err := getFQDN(origin)
	if err != nil {
		//golog.Log.Error(err)
		return false
	}

	allow := util.StringArrayContains(AllowedOrigins, u)
	if !allow {
		//golog.Log.Warningf("CORS: Denied origin [%s], Not Allowed [%s]", origin, u)
		return false
	}

	//golog.Log.Noticef("CORS: Granted origin [%s], Allowed [%s]", origin, u)

	return true
}
