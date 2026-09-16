/**
 * contact.js
 * Handles contact form submission via the PHP/MySQL backend.
 */

document.addEventListener('DOMContentLoaded', () => {
    const contactForm   = document.getElementById('contact-form');
    const contactStatus = document.getElementById('contact-status');

    if (!contactForm || !contactStatus) return;

    contactForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        const submitBtn   = contactForm.querySelector('button[type="submit"]');
        const originalTxt = submitBtn.textContent;

        // --- Loading state ---
        submitBtn.textContent = 'Sending…';
        submitBtn.disabled    = true;
        setStatus('', '', contactStatus);

        const name    = contactForm.querySelector('input[name="name"]').value.trim();
        const email   = contactForm.querySelector('input[name="email"]').value.trim();
        const message = contactForm.querySelector('textarea[name="message"]').value.trim();

        // --- Client-side validation ---
        if (!name || !email || !message) {
            setStatus('⚠ Please fill in all fields.', 'warning', contactStatus);
            resetBtn(submitBtn, originalTxt);
            return;
        }

        // --- Build absolute backend URL ---
        // Works whether page is served from localhost or via ngrok
        const origin     = window.location.origin;
        const basePath   = window.location.pathname.replace(/\/frontend\/.*$/, '');
        const backendUrl = `${origin}${basePath}/backend/submit_contact.php`;

        try {
            const response = await fetch(backendUrl, {
                method : 'POST',
                headers: { 'Content-Type': 'application/json' },
                body   : JSON.stringify({ name, email, message })
            });

            // Try to parse JSON — if PHP errored out, give a useful message
            let result;
            try {
                result = await response.json();
            } catch {
                const text = await response.text();
                console.error('Non-JSON response from server:', text);
                throw new Error('Server returned an unexpected response. Check PHP error logs.');
            }

            if (result.status === 'success') {
                setStatus('✓ Message sent successfully! I\'ll get back to you soon.', 'success', contactStatus);
                contactForm.reset();
            } else {
                setStatus('✗ ' + (result.message || 'Failed to send message. Please try again.'), 'error', contactStatus);
            }

        } catch (err) {
            console.error('Contact form error:', err);
            setStatus('✗ ' + err.message, 'error', contactStatus);
        } finally {
            resetBtn(submitBtn, originalTxt);
        }
    });

    /* ---- helpers ---- */

    function setStatus(msg, type, el) {
        el.textContent = msg;
        const colors = { success: '#4CAF50', error: '#f44336', warning: '#f0b429', '': 'transparent' };
        el.style.color       = colors[type] || '#f44336';
        el.style.opacity     = msg ? '1' : '0';
        el.style.marginTop   = '10px';
        el.style.fontWeight  = '600';
        el.style.fontSize    = '0.95rem';
        el.style.transition  = 'opacity 0.3s ease';

        if (type === 'success') {
            setTimeout(() => {
                el.style.opacity = '0';
                setTimeout(() => { el.textContent = ''; }, 350);
            }, 6000);
        }
    }

    function resetBtn(btn, txt) {
        btn.textContent = txt;
        btn.disabled    = false;
    }
});
