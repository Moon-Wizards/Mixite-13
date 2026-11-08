/**
 * Uses DOMPurify to purify/sanitise HTML.
 */

import DOMPurify from 'dompurify';

const defTag = [
  'b',
  'blockquote',
  'br',
  'center',
  'code',
  'dd',
  'del',
  'div',
  'dl',
  'dt',
  'em',
  'font',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'hr',
  'i',
  'ins',
  'li',
  'menu',
  'ol',
  'p',
  'pre',
  'span',
  'strong',
  'table',
  'tbody',
  'td',
  'th',
  'thead',
  'tfoot',
  'tr',
  'u',
  'ul',
  // M13 EDIT ADDITION - PAPERWORK
  'small',
  'big',
  'sub',
  'sup',
  'strike',
  's',
  'tt',
  'var',
  'kbd',
  'samp',
  'cite',
  'dfn',
  'abbr',
  'acronym',
  'address',
  'bdo',
  'q',
  'mark',
  'ruby',
  'rt',
  'rp',
  // M13 EDIT ADDITION END
];

// Advanced HTML tags that we can trust admins (but not players) with
const advTag = ['img'];

/* M13 EDIT START - PAPERWORK
// Background is here because it accepts image urls
const defAttr = ['class', 'style', 'background'];

/**
 * Feed it a string and it should spit out a sanitized version.
 *
 * @param input - Input HTML string to sanitize
 * @param advHtml - Flag to enable/disable advanced HTML
 * @param tags - List of allowed HTML tags
 * @param forbidAttr - List of forbidden HTML attributes
 * @param advTags - List of advanced HTML tags allowed for trusted sources
*/
const allowedAttr = [
  'style',
  'color',
  'align',
  'valign',
  'width',
  'height',
  'border',
  'cellpadding',
  'cellspacing',
  'colspan',
  'rowspan',
  'size',
  'face',
  'dir',
  'lang',
  'title',
  'id',
  'nowrap',
  'scope',
  'headers',
  'axis',
  'abbr',
  'alt',
  'bgcolor',
];

const forbiddenAttr = [
  'background',
  'src',
  'href',
  'onclick',
  'onload',
  'onerror',
  'onmouseover',
  'onmouseout',
  'onfocus',
  'onblur',
  'onchange',
  'onsubmit',
  'action',
  'method',
  'target',
  'onreset',
  'onkeydown',
  'onkeyup',
  'onkeypress',
  'onabort',
  'onbeforeunload',
  'onhashchange',
  'onmessage',
  'onoffline',
  'ononline',
  'onpagehide',
  'onpageshow',
  'onpopstate',
  'onresize',
  'onstorage',
  'onunload',
  'oncontextmenu',
  'oninput',
  'oninvalid',
  'onsearch',
  'formaction',
  'form',
  'xmlns',
  'xlink:href',
  'class',
];

const allowedCssProperties = new Set([
  'color',
  'background-color',
  'background-image',
  'background-repeat',
  'background-position',
  'background-size',
  'font-size',
  'font-family',
  'font-weight',
  'font-style',
  'text-align',
  'text-decoration',
  'text-transform',
  'margin',
  'margin-top',
  'margin-bottom',
  'margin-left',
  'margin-right',
  'padding',
  'padding-top',
  'padding-bottom',
  'padding-left',
  'padding-right',
  'border',
  'border-width',
  'border-style',
  'border-color',
  'border-top',
  'border-bottom',
  'border-left',
  'border-right',
  'width',
  'height',
  'max-width',
  'max-height',
  'min-width',
  'min-height',
  'display',
  'float',
  'clear',
  'line-height',
  'letter-spacing',
  'word-spacing',
  'vertical-align',
  'white-space',
  'overflow',
  'text-indent',
  'border-radius',
  'visibility',
  'opacity',
  'position',
  'top',
  'right',
  'bottom',
  'left',
  'z-index',
  'list-style',
  'list-style-type',
  'list-style-position',
  'list-style-image',
  'border-collapse',
]);

const blockedCssValues = [
  'javascript:',
  'expression(',
  'behavior:',
  'moz-binding:',
  '@import',
  'url(',
];

function validateCssStyle(styleValue: string) {
  const blocked: string[] = [];
  const rules: string[] = [];
  for (const rawRule of styleValue.split(';')) {
    const rule = rawRule.trim();
    const colon = rule.indexOf(':');
    if (!rule || colon < 0) continue;
    const property = rule.slice(0, colon).trim().toLowerCase();
    const value = rule.slice(colon + 1).trim();
    if (!allowedCssProperties.has(property)) {
      blocked.push(`${property}: ${value}`);
      continue;
    }
    const lowerValue = value.toLowerCase();
    const unsafe =
      property === 'background-image'
        ? (lowerValue.includes('url(') && !lowerValue.includes('data:')) ||
          lowerValue.includes('javascript:') ||
          lowerValue.includes('expression(')
        : blockedCssValues.some((item) => lowerValue.includes(item));
    if (unsafe) {
      blocked.push(`${property}: ${value}`);
      continue;
    }
    rules.push(`${property}: ${value}`);
  }
  return { sanitized: rules.join('; '), blocked };
}

export function sanitizeText(
  input: string,
  advHtml?: boolean,
  tags?: string[],
  allowAttr?: string[],
  advTags?: string[],
): string;
export function sanitizeText(
  input: string,
  advHtml?: boolean,
  tags?: string[],
  allowAttr?: string[],
  advTags?: string[],
  withDetails?: boolean,
): string | { sanitized: string; blockedSummary?: string };
// M13 EDIT ADDITION END

/* // M13 EDIT - PAPERWORK ORIGINAL:
export function sanitizeText(
  input: string,
  advHtml = false,
  tags = defTag,
  forbidAttr = defAttr,
  advTags = advTag,
) {
  // This is VERY important to think first if you NEED
  // the tag you put in here. We are pushing all this
  // though dangerouslySetInnerHTML and even though
  // the default DOMPurify kills javascript, it doesn't
  // kill href links or such
  if (advHtml) {
    tags = tags.concat(advTags);
    forbidAttr = [];
  }
  return DOMPurify.sanitize(input, {
    ALLOWED_TAGS: tags,
    FORBID_ATTR: forbidAttr,
  });
}
*/
export function sanitizeText(
  input: string,
  advHtml = false,
  tags = defTag,
  allowAttr = allowedAttr,
  advTags = advTag,
  withDetails = false,
): string | { sanitized: string; blockedSummary?: string } {
  const allTags = advHtml ? tags.concat(advTags) : tags;
  const blocked: string[] = [];
  const processedInput = input.replace(
    /style\s*=\s*["']([^"']+)["']/gi,
    (_match, styleValue: string) => {
      const result = validateCssStyle(styleValue);
      blocked.push(...result.blocked);
      return result.sanitized ? `style="${result.sanitized}"` : '';
    },
  );
  const sanitized = DOMPurify.sanitize(processedInput, {
    ALLOWED_TAGS: allTags,
    ALLOWED_ATTR: allowAttr,
    FORBID_ATTR: forbiddenAttr,
  });
  return blocked.length && withDetails
    ? { sanitized, blockedSummary: `Blocked CSS: ${blocked.join(', ')}` }
    : sanitized;
}
// M13 EDIT END
